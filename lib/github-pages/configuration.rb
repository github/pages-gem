module GitHubPages
  class Configuration

    # Plugins which are activated by default
    DEFAULT_PLUGINS = %w[
      jekyll-coffeescript
      jekyll-gist
      jekyll-paginate
    ].freeze

    # Plugins allowed by GitHub Pages
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

    # Default, user overwritable options
    DEFAULTS = {
      "gems"     => DEFAULT_PLUGINS,
      "kramdown" => {
        "input"     => "GFM",
        "hard_wrap" => false
      },
      "jailed"   => false
    }.freeze

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
        "template"          => '',
        'math_engine'       => 'mathajx',
        'syntax_highligher' => 'rouge'
      },
      "gist"        => {
        "noscript"  => false
      }
    }.freeze

    # Options which should be honored *locally* for practical purposes, however
    # these options are not honored when built by GitHub Pages
    LOCAL_PASS_THROUGH = %w[
      config
      destination
      source
      future
      limit_posts
      watchforce_polling
      show_drafts
      unbpublished
      quiet
      verbose
      incremental
    ].freeze

    # Given a user's config, determines the effective configuration by building a user
    # configuration sandwhich with our overrides overriding the user's specified
    # values which themselves override our defaults.
    #
    # Returns the effective Configuration
    #
    # Note: this is a highly modified version of Jekyll#configuration
    def self.effective_config(user_config, environment_overrides={})
      # Jekyll defaults < GitHub Pages defaults
      defaults = Jekyll::Utils.deep_merge_hashes(Jekyll::Configuration::DEFAULTS, DEFAULTS)

      # Our overrides, optionally with environment-specific overrides passed at runtime
      overrides = Jekyll::Configuration[OVERRIDES].stringify_keys
      environment_overrides = Jekyll::Configuration[environment_overrides].stringify_keys
      overrides = Jekyll::Utils.deep_merge_hashes(overrides, environment_overrides)

      # defaults < _config.yml < OVERRIDES
      config = Jekyll::Configuration[defaults]
      config = config.read_config_files(config.config_files(overrides))
      config = Jekyll::Utils.deep_merge_hashes(config, overrides).stringify_keys

      # Jekyll's native deep_merge_hashes doesn't merge arrays.
      # Include default Gems, even if not requested, to avoid breaking pre 3.0 sites
      config["gems"] = (config["gems"] | DEFAULT_PLUGINS).uniq

      config
    end

    # Set the site's configuration  Implemented as an `after_reset` hook.
    def self.set(site)
      environment_overrides = {}
      LOCAL_PASS_THROUGH.each { |key| environment_overrides[key] = site.config[key] }
      config = Configuration.effective_config(site.config, environment_overrides)

      # Write the final config to the site object, noting that some values may
      # have already been set as instancee variables when initialized
      site.instance_variable_set '@config', config
      config.keys.each do |key|
        site.public_send("#{key}=", config[key]) if site.respond_to?("#{key}=")
      end
    end
  end
end
