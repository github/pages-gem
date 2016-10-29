# frozen_string_literal: true
require "spec_helper"

describe(GitHubPages::Configuration) do
  let(:test_config) do
    {
      "source" => fixture_dir,
      "quiet" => true,
      "testing" => "123",
      "destination" => tmp_dir
    }
  end
  let(:configuration) { Jekyll.configuration(test_config) }
  let(:site)          { Jekyll::Site.new(configuration) }
  let(:effective_config) { described_class.effective_config(site.config) }
  before(:each) { ENV.delete("DISABLE_WHITELIST") }
  before(:each) { ENV["JEKYLL_ENV"] = "test" }

  context "#effective_config" do
    it "sets configuration defaults" do
      expect(effective_config["kramdown"]["input"]).to eql("GFM")
      expect(effective_config["future"]).to eql(false)
    end

    it "sets default gems" do
      expect(effective_config["gems"]).to include("jekyll-coffeescript")
    end

    it "lets the user specify additional gems" do
      expect(effective_config["gems"]).to include("jekyll-sitemap")
    end

    it "honors the user's config" do
      expect(effective_config["some_key"]).to eql("some_value")
    end

    it "sets overrides" do
      expect(effective_config["highlighter"]).to eql("rouge")
    end

    it "overrides user's values" do
      expect(effective_config["safe"]).to eql(true)
      expect(effective_config["quiet"]).to eql(true)
    end

    it "passes passthroughs" do
      expect(effective_config["quiet"]).to eql(true)
      expect(effective_config["source"]).to eql(fixture_dir)
    end

    it "accepts local configs" do
      expect(effective_config["testing"]).to eql("123")
    end
  end

  context "#set being called via the hook" do
    let(:test_config) do
      {
        "source" => fixture_dir,
        "quiet" => true,
        "testing" => "123",
        "destination" => tmp_dir,
        "future" => true
      }
    end

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
      expect(site.config["future"]).to eql(true)
    end

    it "sets overrides" do
      expect(site.config["highlighter"]).to eql("rouge")
    end

    it "overrides user's values" do
      expect(site.config["safe"]).to eql(true)
      expect(site.config["quiet"]).to eql(true)
    end

    it "passes passthroughs" do
      expect(site.config["quiet"]).to eql(true)
      expect(site.config["source"]).to eql(fixture_dir)
    end

    it "accepts local configs" do
      expect(site.config["testing"]).to eql("123")
    end
  end

  context "plugins" do
    context "whitelists all default plugins" do
      GitHubPages::Configuration::DEFAULT_PLUGINS.each do |plugin|
        it "whitelists the #{plugin} plugin" do
          expect(GitHubPages::Configuration::PLUGIN_WHITELIST).to include(plugin)
        end
      end
    end

    context "versions all whitelisted plugins" do
      GitHubPages::Configuration::PLUGIN_WHITELIST.each do |plugin|
        it "versions the #{plugin} plugin" do
          expect(GitHubPages::Dependencies::VERSIONS.keys).to include(plugin)
        end
      end
    end

    context "in development" do
      before { ENV["JEKYLL_ENV"] = "development" }

      context "without the DISABLE_WHITELIST flag" do
        it "doesn't include additional whitelisted plugins" do
          expect(site.config["whitelist"]).not_to include("jekyll_test_plugin_malicious")
        end

        it "knows not to disable the whitelist" do
          expect(described_class.disable_whitelist?).to eql(false)
        end
      end

      context "with the DISABLE_WHITELIST flag" do
        before { ENV["DISABLE_WHITELIST"] = "1" }

        it "includes additional plugins in the whitelist" do
          expect(site.config["whitelist"]).to include("jekyll_test_plugin_malicious")
        end

        it "fires additional non-whitelisted plugins" do
          expect { site.process }.to raise_error "ALL YOUR COMPUTER ARE BELONG TO US"
        end

        it "knows to disable the whitelist" do
          expect(described_class.disable_whitelist?).to eql(true)
        end
      end
    end

    context "in production" do
      before { ENV["JEKYLL_ENV"] = "production" }

      context "without the DISABLE_WHITELIST flag" do
        it "doesn't include additional whitelisted plugins" do
          expect(site.config["whitelist"]).not_to include("jekyll_test_plugin_malicious")
        end

        it "knows not to disable the whitelist" do
          expect(described_class.disable_whitelist?).to eql(false)
        end
      end

      context "with the DISABLE_WHITELIST flag" do
        before { ENV["DISABLE_WHITELIST"] = "1" }

        it "doesn't include additional whitelisted plugins" do
          expect(site.config["whitelist"]).not_to include("jekyll_test_plugin_malicious")
        end

        it "knows not to disable the whitelist" do
          expect(described_class.disable_whitelist?).to eql(false)
        end
      end
    end
  end
end
