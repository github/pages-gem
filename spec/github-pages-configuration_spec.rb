require 'spec_helper'

describe(GitHubPages::Configuration) do
  let(:configuration) { Jekyll.configuration(source: fixture_dir, quiet: true)}
  let(:site) { Jekyll::Site.new(configuration) }
  let(:effective_config) { described_class.effective_config(site) }
  let(:site_config) { site.config }

  %w[site effective].each do |type|
    context "the #{type} config" do
      let(:config) do
        if type == "site"
          site_config
        elsif type == "effective"
          effective_config
        end
      end

      it "sets configuration defaults" do
        expect(config["kramdown"]["input"]).to eql("GFM")
      end

      it "sets default gems" do
        expect(config["gems"]).to include("jekyll-coffeescript")
      end

      it "lets the user specify additional gems" do
        expect(config["gems"]).to include("jekyll-sitemap")
      end

      it "honors the user's config" do
        expect(config["some_key"]).to eql("some_value")
      end

      it "sets overrides" do
        expect(config["highlighter"]).to eql("rouge")
      end

      it "overrides user's values" do
        expect(config["safe"]).to eql(true)
      end
    end
  end
end
