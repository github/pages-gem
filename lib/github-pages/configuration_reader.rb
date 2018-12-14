# frozen_string_literal: true

module GitHubPages
  # Reads configuration files.
  class ConfigurationReader
    # Determine configuration files for a site source and read the file(s).
    # It should be used in conjunction with GitHubPages::Configuration.
    # This simply reads the files and merges them.
    def self.read_for_site(source)
      read(*configuration_files_for(source))
    end

    # Read one or more configuration files and merge them such that each subsequent
    # file's contents overwrites the previous file's contents.
    def self.read(*filenames)
      filenames.flatten.each_with_object(Jekyll::Configuration.new) do |filename, config|
        Jekyll::Utils.deep_merge_hashes!(config, new(filename).read)
      end
    end

    def self.configuration_files_for(source)
      Jekyll::Configuration.new.config_files("source" => source, "quiet" => true)
    end

    ##################
    # Instance methods
    ##################

    attr_reader :filename
    def initialize(filename)
      @filename = filename
    end

    def read
      user_config
    end

    private

    # User config, with common issues fixed & backwards compatibilized
    def user_config
      @user_config ||= fix(Jekyll::Configuration[raw_user_config]) \
        .backwards_compatibilize.add_default_collections
    end

    # User config, before our overrides, used for metrics and warnings
    def raw_user_config
      @raw_user_config ||= begin
        Jekyll::Configuration.new.read_config_file(filename)
      # Ignore problems parsing the file. Here, they don't matter,
      # we're just looking for the values that were requested. If
      # the config file is really busted, the Jekyll build may fail,
      # and it'll report the error to us and to the site owner.
      rescue ArgumentError, LoadError
        Jekyll::Configuration.new
      end
    end

    # Fix issues to prevent Jekyll from doing strange things.
    # In this case, Configuration#check_maruku aborts the process;
    # we want to simply overwrite with our kramdown default instead.
    def fix(config)
      if config.fetch("markdown", "kramdown").to_s.casecmp("maruku").zero?
        Jekyll.logger.warn "Configuration:", \
          "maruku is no longer supported; using kramdown instead."
        config["markdown"] = "kramdown"
      end

      config
    end
  end
end
