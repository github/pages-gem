module PagesGem
  PRODUCTION_RUBY = '~> 1.9'

  require 'RedCloth'
  require 'jekyll'
  require 'kramdown'
  require 'liquid'
  require 'maruku'
  require 'rdiscount'
  require 'redcarpet'

  unless Gem::Requirement.new(PRODUCTION_RUBY.dup).satisfied_by?(Gem::Version.new(RUBY_VERSION.dup))
    puts "WARN: You are using Ruby 2.0, which is not officially " +
         "supported by GitHub pages. You should switch to Ruby 1.9 " +
         "to most closely match GitHub's production environment."
  end
end
