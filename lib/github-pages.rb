require_relative "./version.rb"
require 'RedCloth'
require 'jekyll'
require 'liquid'
require 'maruku'
require 'kramdown'
require 'rdiscount'

class GitHubPages
  def self.versions
    {
      "github-pages" => GitHubPages::VERSION.to_s,
      "RedCloth" => RedCloth::VERSION.to_s,
      "jekyll" => Jekyll::VERSION,
      #"liquid" => Liquid::VERSION,
      "maruku" => Maruku::VERSION,
      "kramdown" => Kramdown::VERSION,
      "RDiscount" => RDiscount::VERSION
    }
  end
end
