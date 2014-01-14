class GitHubPages
  VERSION = 13

  # Jekyll and related dependency versions as used by GitHub Pages.
  # For more information see:
  # https://help.github.com/articles/using-jekyll-with-pages
  def self.gems
    {
      "github-pages" => VERSION.to_s,
      "jekyll"       => "1.4.2",
      "kramdown"     => "1.3.1",
      "liquid"       => "2.5.5",
      "maruku"       => "0.7.0",
      "rdiscount"    => "2.1.7",
      "redcarpet"    => "2.3.0",
      "RedCloth"     => "4.2.9"
    }
  end
end
