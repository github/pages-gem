require File.expand_path('../lib/github-pages', __FILE__)

Gem::Specification.new do |s|
  s.required_ruby_version = ">= 1.9.3"

  s.name                  = "github-pages"
  s.version               = GitHubPages::VERSION
  s.summary               = "Track GitHub Pages dependencies."
  s.description           = "Bootstrap the GitHub Pages Jekyll environment locally."
  s.authors               = "GitHub, Inc."
  s.email                 = "support@github.com"
  s.homepage              = "https://github.com/github/pages-gem"
  s.license               = "MIT"
  s.files                 = ["lib/github-pages.rb"]

  GitHubPages.gems.each do |gem, version|
    s.add_dependency(gem, "= #{version}")
  end
end
