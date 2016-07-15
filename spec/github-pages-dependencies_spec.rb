require "spec_helper"

describe(GitHubPages::Dependencies) do
  CORE_DEPENDENCIES = %w(
    jekyll kramdown liquid rouge jekyll-sass-converter
    github-pages-health-check listen activesupport
  ).freeze
  PLUGINS = described_class::VERSIONS.keys - CORE_DEPENDENCIES

  it "exposes its gem versions" do
    expect(described_class.gems).to be_a(Hash)
  end

  it "exposes relevant versions of dependencies, self and Ruby" do
    expect(described_class.versions).to be_a(Hash)
    expect(described_class.versions).to include("ruby")
    expect(described_class.versions).to include("github-pages")
  end

  context "jekyll core dependencies" do
    CORE_DEPENDENCIES.each do |gem|
      it "exposes #{gem} dependency version" do
        expect(described_class.gems[gem]).to be_a(String)
        expect(described_class.gems[gem]).not_to be_empty
      end
    end
  end

  context "plugins" do
    PLUGINS.each do |plugin|
      it "whitelists the #{plugin} plugin" do
        expect(GitHubPages::Configuration::PLUGIN_WHITELIST).to include(plugin)
      end
    end
  end

  it "exposes versions as Strings only" do
    described_class.versions.values.each do |version|
      expect(version).to be_a(String)
    end
  end
end
