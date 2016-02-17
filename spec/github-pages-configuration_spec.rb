require 'spec_helper'

describe(GitHubPages::Configuration) do
  let(:configuration) { Jekyll.configuration(source: fixture_dir, quiet: true)}
  let(:site) { Jekyll::Site.new(configuration) }

  it "sets configuration defaults" do
    expect(site.config["kramdown"]["input"]).to eql("GFM")
  end

  it "sets default gems" do
    expect(site.config["gems"]).to include("jekyll-coffeescript")
  end

  it "lets the user specify additional gems" do
    expect(site.config["gems"]).to include("jekyll-sitemap")
  end

  it "honors the user's config" do
    expect(site.config["some_key"]).to eql("some_value")
  end

  it "sets overrides" do
    expect(site.config["highlighter"]).to eql("rouge")
  end

  it "overrides user's values" do
    expect(site.config["safe"]).to eql(true)
  end
end
