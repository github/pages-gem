require 'open-uri'
require 'json'

class GitHubPages

  ENDPOINT = "http://pages.github.com/versions.json"

  # Checks if an update is available for the Pages Gem
  #
  # returns false if up to date
  # returns a descriptive string if an update is available
  # returns nil in the event of any error (e.g., no internet)
  def self.update_available?
    begin
      versions = JSON.parse(open(ENDPOINT).read)
      if GitHubPages::VERSION.to_i >= versions["github-pages"].to_i
        false
      else
        <<-ERROR
You are currently running version #{GitHubPages::VERSION} of the GitHub Pages Gem.
The latest version is version #{versions["github-pages"]}. Please consider updating
to ensure that sites previewed locally better match sites built on GitHub Pages.

https://help.github.com/articles/using-jekyll-with-pages#keeping-jekyll-up-to-date

ERROR
      end
    rescue StandardError => error
    end
  end
end
