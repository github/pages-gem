# frozen_string_literal: true

module GitHubPages
  # Manages the constants that govern which plugins are allowed on GitHub Pages
  class Plugins
    # Plugins which are activated by default
    DEFAULT_PLUGINS = %w(
      jekyll-coffeescript
      jekyll-commonmark-ghpages
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
      jekyll-commonmark-ghpages
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
      jekyll-octicons
      jekyll-remote-theme
    ).freeze

    # Plugins only allowed locally
    DEVELOPMENT_PLUGINS = %w(
      jekyll-admin
    ).freeze

    # Themes
    THEMES = {
      "minima" => "2.5.1",
    }.freeze

    # Themes to convert to remote themes
    THEMES_TO_CONVERT_TO_REMOTE_THEMES = {
      "jekyll-swiss" => "broccolini/swiss",
      "jekyll-theme-primer" => "pages-themes/primer@v0.5.4",
      "jekyll-theme-architect" => "pages-themes/architect@v0.1.1",
      "jekyll-theme-cayman" => "pages-themes/cayman@v0.1.1",
      "jekyll-theme-dinky" => "pages-themes/dinky@v0.1.1",
      "jekyll-theme-hacker" => "pages-themes/hacker@v0.1.1",
      "jekyll-theme-leap-day" => "pages-themes/leap-day@v0.1.1",
      "jekyll-theme-merlot" => "pages-themes/merlot@v0.1.1",
      "jekyll-theme-midnight" => "pages-themes/midnight@v0.1.1",
      "jekyll-theme-minimal" => "pages-themes/minimal@v0.1.1",
      "jekyll-theme-modernist" => "pages-themes/modernist@v0.1.1",
      "jekyll-theme-slate" => "pages-themes/slate@v0.1.1",
      "jekyll-theme-tactile" => "pages-themes/tactile@v0.1.1",
      "jekyll-theme-time-machine" => "pages-themes/time-machine@v0.1.1",
    }
  end
end
