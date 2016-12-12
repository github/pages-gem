# frozen_string_literal: true
module GitHubPages
  # Dependencies is where all the public dependencies for GitHub Pages are defined,
  # and versions locked. Any plugin for Pages must be specified here with a
  # corresponding version to which it shall be locked in the runtime dependencies.
  class Dependencies
    VERSIONS = {
      # Jekyll
      "jekyll"                    => "3.3.1",
      "jekyll-sass-converter"     => "1.3.0",

      # Converters
      "kramdown"                  => "1.11.1",

      # Misc
      "liquid"                    => "3.0.6",
      "rouge"                     => "1.11.1",
      "github-pages-health-check" => "1.3.0",

      # Plugins
      "jekyll-redirect-from"   => "0.11.0",
      "jekyll-sitemap"         => "0.12.0",
      "jekyll-feed"            => "0.8.0",
      "jekyll-gist"            => "1.4.0",
      "jekyll-paginate"        => "1.1.0",
      "jekyll-coffeescript"    => "1.0.1",
      "jekyll-seo-tag"         => "2.1.0",
      "jekyll-github-metadata" => "2.2.0",
      "jekyll-avatar"          => "0.4.2",

      # Plugins to match GitHub.com Markdown
      "jemoji"                       => "0.7.0",
      "jekyll-mentions"              => "1.2.0",
      "jekyll-relative-links"        => "0.2.1",
      "jekyll-optional-front-matter" => "0.1.2",
      "jekyll-readme-index"          => "0.0.3",
      "jekyll-default-layout"        => "0.1.4",
      "jekyll-titles-from-headings"  => "0.1.2",

      # Pin listen because it's broken on 2.1 & that's what we recommend.
      # https://github.com/guard/listen/pull/371
      "listen"                    => "3.0.6",

      # Pin activesupport because 5.0 is broken on 2.1
      "activesupport"             => "4.2.7"
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

      {
        "ruby" => RUBY_VERSION,

        # Gem versions we're curious about
        "github-pages"  => VERSION.to_s,
        "html-pipeline" => HTML::Pipeline::VERSION,
        "sass"          => Sass.version[:number],
        "safe_yaml"     => SafeYAML::VERSION
      }
    end
  end
end
