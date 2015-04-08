class GitHubPages
  VERSION = 34

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
      "kramdown"              => "1.5.0",
      "maruku"                => "0.7.0",
      "rdiscount"             => "2.1.7",
      "redcarpet"             => "3.1.2",
      "RedCloth"              => "4.2.9",

      # Liquid
      "liquid"                => "2.6.1",

      # Highlighters
      "pygments.rb"           => "0.6.1",

      # Plugins
      "jemoji"                => "0.4.0",
      "jekyll-mentions"       => "0.2.1",
      "jekyll-redirect-from"  => "0.6.2",
      "jekyll-sitemap"        => "0.8.1",
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
