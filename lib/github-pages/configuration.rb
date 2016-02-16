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

    OVERRIDES = {
      "source"      => Dir.pwd,
      "destination" => File.expand_path("_site", Dir.pwd),
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

    def self.set(site)
      user_config_overridden = Jekyll.configuration(OVERRIDES)
      config = Jekyll::Utils.deep_merge_hashes(DEFAULTS, user_config_overridden)

      site.instance_variable_set '@config', config
      config.keys.each do |key|
        site.send("#{key}=", config[key]) if site.respond_to?("#{key}=")
      end
    end
  end
end
