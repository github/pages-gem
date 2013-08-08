Gem::Specification.new do |s|
  s.rubygems_version      = "1.8.0"
  s.required_ruby_version = ">= 1.9.3"

  s.name                  = "github-pages"
  s.version               = "0.0.1"
  s.summary               = "Track GitHub Pages dependencies."
  s.description           = "Bootstrap the GitHub Pages Jekyll environment locally."
  s.authors               = "GitHub, Inc."
  s.email                 = "support@github.com"
  s.homepage              = "http://pages.github.com"
  s.license               = "MIT"

  # Note to future Hubbers: Update the help docs if you bump the dependency versions
  # https://help.github.com/articles/using-jekyll-with-pages

  s.add_dependency("RedCloth",   "= 4.2.9")
  s.add_dependency("jekyll",     "= 1.1.2")
  s.add_dependency("kramdown",   "= 1.0.2")
  s.add_dependency("liquid",     "= 2.5.1")
  s.add_dependency("maruku",     "= 0.6.1")
  s.add_dependency("rdiscount",  "= 1.6.8")
  s.add_dependency("redcarpet",  "= 2.2.2")
end
