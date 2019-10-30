# frozen_string_literal: true

require "spec_helper"

describe(GitHubPages::Plugins) do
  context "whitelists all default plugins" do
    GitHubPages::Plugins::DEFAULT_PLUGINS.each do |plugin|
      it "whitelists the #{plugin} plugin" do
        expect(GitHubPages::Plugins::PLUGIN_WHITELIST).to include(plugin)
      end
    end
  end

  context "versions all whitelisted plugins" do
    GitHubPages::Plugins::PLUGIN_WHITELIST.each do |plugin|
      it "versions the #{plugin} plugin" do
        next if plugin == "jekyll-include-cache"
        next if plugin == "jekyll-octicons" # TODO: we should expose the version for these

        expect(GitHubPages::Dependencies::VERSIONS.keys).to include(plugin)
      end
    end
  end
end
