require File.expand_path("../lib/github-pages", __FILE__)

Gem::Specification.new do |s|
  s.required_ruby_version = ">= 2.0.0"

  s.name                  = "github-pages"
  s.version               = GitHubPages::VERSION
  s.summary               = "Track GitHub Pages dependencies."
  s.description           = "Bootstrap the GitHub Pages Jekyll environment locally."
  s.authors               = "GitHub, Inc."
  s.email                 = "support@github.com"
  s.homepage              = "https://github.com/github/pages-gem"
  s.license               = "MIT"
  s.executables           = ["github-pages"]
  s.files                 = ["lib/github-pages.rb"]

  s.post_install_message = <<-msg
---------------------------------------------------
Thank you for installing github-pages!
GitHub Pages recently upgraded to Jekyll 3.0, which
includes some breaking changes. More information:
https://github.com/blog/2100-github-pages-jekyll-3
---------------------------------------------------
msg

  GitHubPages.gems.each do |gem, version|
    s.add_dependency(gem, "= #{version}")
  end

  s.add_dependency("mercenary", "~> 0.3")
  s.add_dependency("terminal-table", "~> 1.4")
  s.add_development_dependency("rspec", "~> 3.3")
  s.add_development_dependency("rubocop", "~> 0.35")
end
