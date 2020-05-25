# frozen_string_literal: true

require File.expand_path("lib/github-pages/dependencies", __dir__)
require File.expand_path("lib/github-pages/plugins", __dir__)
require File.expand_path("lib/github-pages/version", __dir__)

Gem::Specification.new do |s|
  s.required_ruby_version = ">= 2.3.0"

  s.name                  = "github-pages"
  s.version               = GitHubPages::VERSION
  s.summary               = "Track GitHub Pages dependencies."
  s.description           = "Bootstrap the GitHub Pages Jekyll environment locally."
  s.authors               = "GitHub, Inc."
  s.email                 = "support@github.com"
  s.homepage              = "https://github.com/github/pages-gem"
  s.license               = "MIT"

  all_files               = `git ls-files -z`.split("\x0")
  s.files                 = all_files.grep(%r{^(bin|lib)/|^.rubocop.yml$})
  s.executables           = all_files.grep(%r{^bin/}) { |f| File.basename(f) }

  GitHubPages::Dependencies.gems.each do |gem, version|
    s.add_dependency(gem, "= #{version}")
  end

  s.add_dependency("mercenary", "~> 0.3")
  s.add_dependency("nokogiri", ">= 1.10.4", "< 2.0")
  s.add_dependency("terminal-table", "~> 1.4")
  s.add_development_dependency("jekyll_test_plugin_malicious", "~> 0.2")
  s.add_development_dependency("pry", "~> 0.10")
  s.add_development_dependency("rspec", "~> 3.3")
  s.add_development_dependency("rubocop-github", "0.16.0")
end
