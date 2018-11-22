# frozen_string_literal: true

require "spec_helper"

describe(GitHubPages::Configuration) do
  let(:test_config) do
    {
      "source" => fixture_dir,
      "quiet" => true,
      "testing" => "123",
      "destination" => tmp_dir,
    }
  end
  let(:configuration) { Jekyll.configuration(test_config) }
  let(:site)          { Jekyll::Site.new(configuration) }
  let(:effective_config) { described_class.effective_config(site.config) }
  let(:defaults_for_env) { described_class.defaults_for_env }

  before(:each) do
    ENV.delete("DISABLE_WHITELIST")
    ENV["JEKYLL_ENV"] = "test"
    ENV["PAGES_REPO_NWO"] = "github/pages-gem"
  end

  context "#effective_config" do
    it "sets configuration defaults" do
      expect(effective_config["kramdown"]["input"]).to eql("GFM")
      expect(effective_config["future"]).to eql(false)
    end

    it "sets default gems" do
      expect(effective_config["plugins"]).to include("jekyll-coffeescript")
    end

    it "lets the user specify additional gems" do
      expect(effective_config["plugins"]).to include("jekyll-sitemap")
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

    it "sets exclude directive" do
      expect(effective_config["exclude"]).to include("CNAME")
    end

    it "retains Jekyll default excludes" do
      expect(effective_config["exclude"]).to include(*Jekyll::Configuration::DEFAULTS["exclude"])
    end

    context "markdown processor" do
      context "with no markdown processor set" do
        it "defaults to kramdown" do
          expect(effective_config["markdown"]).to eql("kramdown")
        end
      end

      context "with GFM set" do
        let(:site) do
          config = configuration.merge("markdown" => "GFM")
          Jekyll::Site.new(config)
        end

        it "configures CommonMarkGhPages" do
          expect(effective_config["markdown"]).to eql("CommonMarkGhPages")
          expect(effective_config["commonmark"]).to eql(
            "extensions" => %w(table strikethrough autolink tagfilter),
            "options" => %w(footnotes)
          )
        end
      end

      context "with some other processor set" do
        let(:site) do
          config = configuration.merge("markdown" => "whatever")
          Jekyll::Site.new(config)
        end

        it "overrides to kramdown" do
          expect(effective_config["markdown"]).to eql("kramdown")
        end
      end
    end

    context "themes" do
      context "with no theme set" do
        it "sets the theme" do
          expect(site.theme).to_not be_nil
          expect(site.theme).to be_a(Jekyll::Theme)
          expect(site.theme.name).to eql("jekyll-theme-primer")
        end
      end

      context "with a user-specified theme" do
        let(:site) do
          config = configuration.merge("theme" => "jekyll-theme-merlot")
          Jekyll::Site.new(config)
        end

        it "respects the theme" do
          expect(site.theme).to_not be_nil
          expect(site.theme).to be_a(Jekyll::Theme)
          expect(site.theme.name).to eql("jekyll-theme-merlot")
        end
      end

      context "with user-specified theme to be null" do
        let(:site) do
          config = configuration.merge("theme" => nil)
          Jekyll::Site.new(config)
        end

        it "respects null" do
          expect(site.theme).to be_nil
        end
      end

      it "plugins don't include jekyll remote theme" do
        expect(effective_config["plugins"]).to_not include("jekyll-remote-theme")
      end

      context "with a remote theme" do
        let(:test_config) do
          {
            "source" => fixture_dir,
            "quiet" => true,
            "testing" => "123",
            "destination" => tmp_dir,
            "remote_theme" => "foo/bar",
          }
        end

        it "plugins include jekyll remote theme" do
          expect(effective_config["plugins"]).to include("jekyll-remote-theme")
        end
      end
    end

    context "in development" do
      before { ENV["JEKYLL_ENV"] = "development" }

      it "doesn't compress sass" do
        expect(effective_config["sass"]).to be_nil
        expect(defaults_for_env["sass"]).to be_nil
      end
    end
  end

  context "#set being called via the hook" do
    let(:test_config) do
      {
        "source" => fixture_dir,
        "quiet" => true,
        "testing" => "123",
        "destination" => tmp_dir,
        "future" => true,
      }
    end

    it "sets configuration defaults" do
      expect(site.config["kramdown"]["input"]).to eql("GFM")
    end

    it "sets default gems" do
      expect(site.config["plugins"]).to include("jekyll-coffeescript")
    end

    it "lets the user specify additional gems" do
      expect(site.config["plugins"]).to include("jekyll-sitemap")
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

      it "compresses sass" do
        expect(effective_config["sass"]).to eql("style" => "compressed")
        expect(defaults_for_env["sass"]).to eql("style" => "compressed")
      end
    end
  end
end
