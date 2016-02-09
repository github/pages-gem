class GitHubPages
  VERSION = 48

  # Jekyll and related dependency versions as used by GitHub Pages.
  # For more information see:
  # https://help.github.com/articles/using-jekyll-with-pages
  def self.gems
    {
      # Jekyll
      "jekyll"                    => "3.0.3",
      "jekyll-sass-converter"     => "1.3.0",
      "jekyll-textile-converter"  => "0.1.0",

      # Converters
      "kramdown"                  => "1.9.0",
      "rdiscount"                 => "2.1.8",
      "redcarpet"                 => "3.3.3",
      "RedCloth"                  => "4.2.9",

      # Liquid
      "liquid"                    => "3.0.6",

      # Highlighters
      "rouge"                     => "1.10.1",

      # Plugins
      "jemoji"                    => "0.5.1",
      "jekyll-mentions"           => "1.0.0",
      "jekyll-redirect-from"      => "0.9.1",
      "jekyll-sitemap"            => "0.10.0",
      "jekyll-feed"               => "0.3.1",
      "jekyll-gist"               => "1.4.0",
      "jekyll-paginate"           => "1.1.0",
      "github-pages-health-check" => "0.6.1",
      "jekyll-coffeescript"       => "1.0.1",
      "jekyll-seo-tag"            => "1.0.0",
    }
  end

  # Versions used by GitHub Pages, including github-pages gem and ruby version
  # Useful for programmatically querying for the current-running version
  def self.versions
    gems.merge deps_version_report
  end

  def self.deps_version_report
    require 'html/pipeline/version'
    require 'sass/version'
    require 'safe_yaml/version'

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
