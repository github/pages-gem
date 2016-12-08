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
    ).freeze

    # Plugins only allowed locally
    DEVELOPMENT_PLUGINS = %w(
      jekyll-admin
    ).freeze

    # Themes
    THEMES = {
      "minima"                    => "2.0.0",
      "jekyll-swiss"              => "0.4.0",
      "jekyll-theme-primer"       => "0.1.1"
    }.freeze
  end
end
