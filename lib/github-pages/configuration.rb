module GitHubPages
  #
  class Configuration
    # Plugins which are activated by default
    DEFAULT_PLUGINS = %w(
      jekyll-coffeescript
      jekyll-gist
      jekyll-github-metadata
      jekyll-paginate
      jekyll-textile-converter
    ).freeze

    # Plugins allowed by GitHub Pages
    PLUGIN_WHITELIST = %w(
      jekyll-coffeescript
      jekyll-feed
      jekyll-gist
      jekyll-github-metadata
      jekyll-mentions
      jekyll-paginate
      jekyll-redirect-from
      jekyll-seo-tag
      jekyll-sitemap
      jekyll-textile-converter
      jemoji
    ).freeze

    # Default, user overwritable options
    DEFAULTS = {
      "jailed"   => false,
      "gems"     => DEFAULT_PLUGINS,
      "kramdown" => {
        "input"     => "GFM",
        "hard_wrap" => false
      }
    }.freeze

    # Jekyll defaults merged with Pages defaults.
    MERGED_DEFAULTS = Jekyll::Utils.deep_merge_hashes(
      Jekyll::Configuration::DEFAULTS,
      DEFAULTS
    ).freeze

    # Options which GitHub Pages sets, regardless of the user-specified value
    #
    # The following values are also overridden by GitHub Pages, but are not
    # overridden locally, for practical purposes:
    # * source
    # * destination
    # * jailed
    # * verbose
    # * incremental
    # * GH_ENV
    OVERRIDES = {
      "lsi"         => false,
      "safe"        => true,
      "plugins"     => SecureRandom.hex,
      "whitelist"   => PLUGIN_WHITELIST,
      "highlighter" => "rouge",
      "kramdown"    => {
        "template"           => "",
        "math_engine"        => "mathjax",
        "syntax_highlighter" => "rouge"
      },
      "gist"        => {
        "noscript"  => false
      }
    }.freeze

    # These configuration settings have corresponding instance variables on
    # Jekyll::Site and need to be set properly when the config is updated.
    CONFIGS_WITH_METHODS = %w(
      safe lsi highlighter baseurl exclude include future unpublished
      show_drafts limit_posts keep_files gems
    ).freeze

    class << self
      def processed?(site)
        site.instance_variable_get(:@_github_pages_processed) == true
      end

      def processed(site)
        site.instance_variable_set :@_github_pages_processed, true
      end

      def disable_whitelist?
        Jekyll.env == "development" && !ENV["DISABLE_WHITELIST"].to_s.empty?
      end

      # Given a user's config, determines the effective configuration by building a user
      # configuration sandwhich with our overrides overriding the user's specified
      # values which themselves override our defaults.
      #
      # Returns the effective Configuration
      #
      # Note: this is a highly modified version of Jekyll#configuration
      def effective_config(user_config)
        # Merge user config into defaults
        config = Jekyll::Utils.deep_merge_hashes(MERGED_DEFAULTS, user_config)
          .fix_common_issues
          .add_default_collections

        # Merge overwrites into user config
        config = Jekyll::Utils.deep_merge_hashes config, OVERRIDES

        # Ensure we have those gems we want.
        config["gems"] = Array(config["gems"]) | DEFAULT_PLUGINS
        config["whitelist"] = config["whitelist"] | config["gems"] if disable_whitelist?

        config
      end

      # Set the site's configuration. Implemented as an `after_reset` hook.
      # Equivalent #set! function contains the code of interest. This function
      # guards against double-processing via the value in #processed.
      def set(site)
        return if processed? site
        set!(site)
        processed(site)
      end

      # Set the site's configuration with all the proper defaults and overrides.
      # Should be called by #set to protect against multiple processings.
      def set!(site)
        config = effective_config(site.config)

        # Assign everything to the site
        site.instance_variable_set :@config, config

        # Ensure all
        CONFIGS_WITH_METHODS.each do |opt|
          site.public_send("#{opt}=", site.config[opt])
        end
      end
    end
  end
end
