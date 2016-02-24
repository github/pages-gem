$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'jekyll'

module GitHubPages
  autoload :Configuration, "github-pages/configuration"
  autoload :Dependencies,  "github-pages/dependencies"
end

Jekyll::Hooks.register :site, :after_reset do |site|
  GitHubPages::Configuration.set(site)
end
