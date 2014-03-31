require_relative "version-check"

class GitHubPages
  VERSION = 17

  # Jekyll and related dependency versions as used by GitHub Pages.
  # For more information see:
  # https://help.github.com/articles/using-jekyll-with-pages
  def self.gems
    {
      "jekyll"               => "1.5.1",
      "kramdown"             => "1.3.1",
      "liquid"               => "2.5.5",
      "maruku"               => "0.7.0",
      "rdiscount"            => "2.1.7",
      "redcarpet"            => "2.3.0",
      "RedCloth"             => "4.2.9",
      "jemoji"               => "0.1.0",
      "jekyll-mentions"      => "0.0.6",
      "jekyll-redirect-from" => "0.3.1",
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
