# frozen_string_literal: true
require "typhoeus"

module GitHubPages
  # VersionCheck ensures that the local version is up to date with the
  # latest version deployed to GitHub Pages.
  module VersionCheck
    PRODUCTION_VERSIONS_URL = "https://pages.github.com/versions.json"

    def run!
      @already_run ||=
        begin
          return true if ENV["PAGES_ENV"].to_s.casecmp("enterprise").zero?

          if GitHubPages::VERSION < production_ghp_version
            Jekyll.logger.error "GitHub Pages:", "You are using an outdated version of github-pages."
            Jekyll.logger.error "", "Upgrade to version '#{production_ghp_version}' to ensure your local builds"
            Jekyll.logger.error "", "will accurately reflect what is deployed when you push to GitHub."
            return false
          end

          true
        end
    end

    def production_versions_url
      @production_versions_url ||= PRODUCTION_VERSIONS_URL
    end

    def production_ghp_version
      @production_ghp_version ||= production_versions["github-pages"].to_i
    end

    def production_versions
      @production_versions ||=
        begin
          response = http_get_with_retries(production_versions_url)
          JSON.parse(response.response_body)
        end
    end

    extend self

    private

    # rubocop:disable Lint/HandleExceptions
    def http_get_with_retries(url)
      1.upto(5) do
        begin
          response = Typhoeus.get(url)
          return response if response && response.success?
        rescue
        end
      end
    end
    # rubocop:enable Lint/HandleExceptions
  end
end
