require 'spec_helper'

describe(GitHubPages::Configuration) do
  let(:test_config) { { "source" => fixture_dir, "quiet" => true, "testing" => "123" } }
  let(:configuration) { Jekyll.configuration(test_config)}
  let(:site) { Jekyll::Site.new(configuration) }
  let(:effective_config) { described_class.effective_config(site.config, test_config) }
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
        expect(config["quiet"]).to eql(true)
      end

      it "passes passthroughs" do
        expect(config["quiet"]).to eql(true)
        expect(config["source"]).to eql(fixture_dir)
      end

      if type == "effective"
        it "accepts local configs" do
          expect(config["testing"]).to eql("123")
        end
      end
    end
  end

  context "overrides" do
    let(:overrides) { described_class.overrides(test_config) }

    it "sets the default overrides" do
      expect(overrides["lsi"]).to eql(false)
      expect(overrides["safe"]).to eql(true)
    end

    it "accepts local overrides" do
      expect(overrides["testing"]).to eql("123")
      expect(overrides["quiet"]).to eql(true)
    end
  end
end
