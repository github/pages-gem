# frozen_string_literal: true

module GitHubPages
  # Dependencies is where all the public dependencies for GitHub Pages are defined,
  # and versions locked. Any plugin for Pages must be specified here with a
  # corresponding version to which it shall be locked in the runtime dependencies.
  class Dependencies
    VERSIONS = {
      # Jekyll
      "jekyll"                    => "3.5.1",
      "jekyll-sass-converter"     => "1.5.0",

      # Converters
      "kramdown"                  => "1.13.2",

      # Misc
      "liquid"                    => "4.0.0",
      "rouge"                     => "1.11.1",
      "github-pages-health-check" => "1.3.5",

      # Plugins
      "jekyll-redirect-from"   => "0.12.1",
      "jekyll-sitemap"         => "1.0.0",
      "jekyll-feed"            => "0.9.2",
      "jekyll-gist"            => "1.4.1",
      "jekyll-paginate"        => "1.1.0",
      "jekyll-coffeescript"    => "1.0.1",
      "jekyll-seo-tag"         => "2.2.3",
      "jekyll-github-metadata" => "2.6.0",
      "jekyll-avatar"          => "0.4.2",

      # Plugins to match GitHub.com Markdown
      "jemoji"                       => "0.8.0",
      "jekyll-mentions"              => "1.2.0",
      "jekyll-relative-links"        => "0.4.1",
      "jekyll-optional-front-matter" => "0.2.0",
      "jekyll-readme-index"          => "0.1.0",
      "jekyll-default-layout"        => "0.1.4",
      "jekyll-titles-from-headings"  => "0.4.0",

      # Pin listen because it's broken on 2.1 & that's what we recommend.
      # https://github.com/guard/listen/pull/371
      "listen"                    => "3.0.6",

      # Pin activesupport because 5.0 is broken on 2.1
      "activesupport"             => "4.2.8",
    }.freeze

    # Jekyll and related dependency versions as used by GitHub Pages.
    # For more information see:
    # https://help.github.com/articles/using-jekyll-with-pages
    def self.gems
      VERSIONS.merge(GitHubPages::Plugins::THEMES)
    end

    # Versions used by GitHub Pages, including github-pages gem and ruby version
    # Useful for programmatically querying for the current-running version
    def self.versions
      gems.merge version_report
    end

    def self.version_report
      require "html/pipeline/version"
      require "sass/version"
      require "safe_yaml/version"
      require "nokogiri"

      {
        "ruby" => RUBY_VERSION,

        # Gem versions we're curious about
        "github-pages"  => VERSION.to_s,
        "html-pipeline" => HTML::Pipeline::VERSION,
        "sass"          => Sass.version[:number],
        "safe_yaml"     => SafeYAML::VERSION,
        "nokogiri"      => Nokogiri::VERSION,
      }
    end
  end
end
