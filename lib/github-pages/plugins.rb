# frozen_string_literal: true

module GitHubPages
  # Manages the constants the govern what plugins are allows on GitHub Pages
  class Plugins
    # Plugins which are activated by default
    DEFAULT_PLUGINS = %w(
      jekyll-coffeescript
      jekyll-gist
      jekyll-github-metadata
      jekyll-paginate
      jekyll-relative-links
      jekyll-optional-front-matter
      jekyll-readme-index
      jekyll-default-layout
      jekyll-titles-from-headings
    ).freeze

    # Plugins allowed by GitHub Pages
    PLUGIN_WHITELIST = %w(
      jekyll-coffeescript
      jekyll-feed
      jekyll-gist
      jekyll-github-metadata
      jekyll-paginate
      jekyll-redirect-from
      jekyll-seo-tag
      jekyll-sitemap
      jekyll-avatar
      jemoji
      jekyll-mentions
      jekyll-relative-links
      jekyll-optional-front-matter
      jekyll-readme-index
      jekyll-default-layout
      jekyll-titles-from-headings
      jekyll-include-cache
    ).freeze

    # Plugins only allowed locally
    DEVELOPMENT_PLUGINS = %w(
      jekyll-admin
    ).freeze

    # Themes
    THEMES = {
      "minima"                     => "2.1.1",
      "jekyll-swiss"               => "0.4.0",
      "jekyll-theme-primer"        => "0.4.0",
      "jekyll-theme-architect"     => "0.0.4",
      "jekyll-theme-cayman"        => "0.0.4",
      "jekyll-theme-dinky"         => "0.0.4",
      "jekyll-theme-hacker"        => "0.0.4",
      "jekyll-theme-leap-day"      => "0.0.4",
      "jekyll-theme-merlot"        => "0.0.4",
      "jekyll-theme-midnight"      => "0.0.4",
      "jekyll-theme-minimal"       => "0.0.4",
      "jekyll-theme-modernist"     => "0.0.4",
      "jekyll-theme-slate"         => "0.0.4",
      "jekyll-theme-tactile"       => "0.0.4",
      "jekyll-theme-time-machine"  => "0.0.4",
    }.freeze
  end
end
