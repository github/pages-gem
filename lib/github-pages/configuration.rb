module GitHubPages
  class Configuration

    DEFAULT_PLUGINS = %w[
      jekyll-coffeescript
      jekyll-gist
      jekyll-paginate
    ].freeze

    PLUGIN_WHITELIST = %w[
      jekyll-redirect-from
      jekyll-mentions
      jekyll-sitemap
      jekyll-feed
      jekyll-coffeescript
      jekyll-paginate
      jekyll-seo-tag
      jekyll-gist
      jemoji
    ].freeze

    DEFAULTS = {
      "gems"     => DEFAULT_PLUGINS,
      "kramdown" => {
        "input"     => "GFM",
        "hard_wrap" => false
      }
    }.freeze

    # Note: "source" and "destination" are also overridden, but cannot be
    # overridden locally, for practical purposes
    OVERRIDES = {
      "lsi"         => false,
      "safe"        => true,
      "plugins"     => SecureRandom.hex,
      "whitelist"   => PLUGIN_WHITELIST,
      "incremental" => false,
      "highlighter" => "rouge",
      "kramdown"    => {
        "template"          => '',
        'math_engine'       => 'mathajx',
        'syntax_highligher' => 'rouge'
      },
      "gist"        => {
        "noscript"  => false
      }
    }.freeze

    # Set the site's configuration as a user configuration sandwhich with
    # with our overrides overriding the user's specified values which themselves
    # override our defaults. Implemented as an `after_reset` hook.
    #
    # Note: this is roughly a modified version of Jekyll#configuration
    def self.set(site)
      # Jekyll defaults < GitHub Pages defaults
      defaults = Jekyll::Utils.deep_merge_hashes(Jekyll::Configuration::DEFAULTS, DEFAULTS)

      # defaults < the site's existing source and destination
      # so that Jekyll can find the user's config
      passthrough = {
        "source"      => site.config["source"],
        "destination" => site.config["destination"]
      }
      defaults = Jekyll::Utils.deep_merge_hashes(defaults, passthrough)

      # defaults < _config.yml < OVERRIDES
      config   = Jekyll::Configuration[defaults]
      override = Jekyll::Configuration[OVERRIDES].stringify_keys
      config   = config.read_config_files(config.config_files(override))
      config   = Jekyll::Utils.deep_merge_hashes(config, override).stringify_keys

      # Write the final config to the site object, noting that some values may
      # have already been set as instancee variables when initialized
      site.instance_variable_set '@config', config
      config.keys.each do |key|
        site.public_send("#{key}=", config[key]) if site.respond_to?("#{key}=")
      end
    end
  end
end
