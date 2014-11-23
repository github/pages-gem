class GitHubPages
  VERSION = 29

  # Jekyll and related dependency versions as used by GitHub Pages.
  # For more information see:
  # https://help.github.com/articles/using-jekyll-with-pages
  def self.gems
    {
      # Jekyll
      "jekyll"                => "2.4.0",
      "jekyll-coffeescript"   => "1.0.1",
      "jekyll-sass-converter" => "1.2.0",

      # Converters
      "kramdown"              => "1.3.1",
      "maruku"                => "0.7.2",
      "rdiscount"             => "2.1.7",
      "redcarpet"             => "3.1.2",
      "RedCloth"              => "4.2.9",

      # Liquid
      "liquid"                => "2.6.1",

      # Highlighters
      "pygments.rb"           => "0.6.0",

      # Plugins
      "jemoji"                => "0.3.0",
      "jekyll-mentions"       => "0.1.3",
      "jekyll-redirect-from"  => "0.6.2",
      "jekyll-sitemap"        => "0.6.3",
    }
  end

  # Versions used by GitHub Pages, including github-pages gem and ruby version
  # Useful for programmatically querying for the current-running version
  def self.versions
    gems.merge({
      "github-pages" => VERSION.to_s,
      "ruby"         => RUBY_VERSION
    })
  end
end
