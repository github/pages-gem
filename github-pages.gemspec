Gem::Specification.new do |s|
  s.required_ruby_version = ">= 1.9.3"

  s.name                  = "github-pages"
  s.version               = "5"
  s.summary               = "Track GitHub Pages dependencies."
  s.description           = "Bootstrap the GitHub Pages Jekyll environment locally."
  s.authors               = "GitHub, Inc."
  s.email                 = "support@github.com"
  s.homepage              = "https://github.com/github/pages-gem"
  s.license               = "MIT"

  # Jekyll and related dependency versions as used by GitHub Pages.
  # For more information see:
  # https://help.github.com/articles/using-jekyll-with-pages

  s.add_dependency("RedCloth",   "= 4.2.9")
  s.add_dependency("jekyll",     "= 1.2.0")
  s.add_dependency("kramdown",   "= 1.0.2")
  s.add_dependency("liquid",     "= 2.5.1")
  s.add_dependency("maruku",     "= 0.6.1")
  s.add_dependency("rdiscount",  "= 1.6.8")
  s.add_dependency("redcarpet",  "= 2.2.2")
end
