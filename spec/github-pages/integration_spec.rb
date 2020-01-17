# frozen_string_literal: true

RSpec.describe "Pages Gem Integration spec" do
  def destination_file(file)
    File.join tmp_dir, file
  end

  def source
    @source ||= fixture_dir
  end

  def destination
    @destination ||= tmp_dir
  end

  def gemfile
    "#{source}/Gemfile"
  end

  def env
    {
      "BUNDLE_GEMFILE" => gemfile,
      "JEKYLL_ENV" => "development",
      "DISABLE_WHITELIST" => "", # Do not disable the whitelist.
    }
  end

  def run_cmd(cmd)
    output, status = Open3.capture2e env, *cmd
    raise StandardError, output if status.exitstatus != 0

    output
  end

  def build(additional_flags = nil)
    Dir.chdir(source) do
      cmd = %w(bundle exec jekyll build --verbose --trace)
      cmd = cmd.concat ["--source", source, "--destination", destination]
      cmd = cmd.concat(additional_flags) if additional_flags
      run_cmd(cmd)
    end
  end

  def bundle_install
    Dir.chdir(source) do
      File.unlink "#{gemfile}.lock" if File.exist? "#{gemfile}.lock"
      run_cmd %w(gem install bundler)
      run_cmd %w(bundle install)
    end
  end

  def rm_destination
    FileUtils.rm_rf(destination)
  end

  let(:file) { "#{self.class.description}.html" }
  let(:path) { destination_file file }
  let(:contents) { File.read path }
  after(:all) { rm_destination }

  context "fixture site with default config" do
    before(:all) do
      rm_destination
      bundle_install
      build
    end

    it "tests all dependencies" do
      contents = File.read(__FILE__)
      contexts = contents.scan(/context \"(.*?)\"/)
      missing = GitHubPages::Dependencies::VERSIONS.keys - contexts.flatten
      missing -= %w(github-pages-health-check)
      msg = "The following dependencies are missing integration tests: #{missing.join(", ")}"
      expect(missing).to be_empty, msg
    end

    context "jekyll" do
      it "builds" do
        expect(path).to be_an_existing_file
      end
    end

    context "jekyll-sass-converter" do
      let(:file) { "jekyll-sass-converter.css" }

      it "Renders SCSS" do
        expect(path).to be_an_existing_file
        expect(contents).to match("body { color: #333; }")
      end
    end

    context "kramdown" do
      it "converts markdown to HTML" do
        expect(contents).to match('<h1 id="test">Test</h1>')
      end
    end

    context "liquid" do
      it "renders liquid templates" do
        expect(contents).to match("Value of foo: bar")
      end
    end

    context "rouge" do
      it "syntax highlights" do
        expected = '<div class="language-ruby highlighter-rouge">'.dup
        expected << '<div class="highlight"><pre class="highlight">'
        expected << '<code><span class="nb">'
        expected << 'puts</span> <span class="s2">"hello world"'
        expect(contents).to match(expected)
      end
    end

    context "jekyll-redirect-from" do
      context "redirect_from" do
        let(:file) { "redirect/index.html" }

        it "redirects from" do
          expect(path).to be_an_existing_file
          expected = '<meta http-equiv="refresh" content="0; url=/redirect_from.html">'
          expect(contents).to match(expected)
        end
      end

      context "redirect_to" do
        it "redirects to" do
          expect(path).to be_an_existing_file
          expected = '<meta http-equiv="refresh" content="0; url=/someplace-else/">'
          expect(contents).to match(expected)
        end
      end
    end

    context "jekyll-sitemap" do
      let(:file) { "sitemap.xml" }

      it "builds the sitemap" do
        expect(path).to be_an_existing_file
        expect(contents).to match("<loc>/jekyll.html</loc>")
      end
    end

    context "jekyll-feed" do
      let(:file) { "feed.xml" }

      it "builds the feed" do
        expect(path).to be_an_existing_file
        expected = '<title type="html">Test</title><link href="/2017/01/10/test.html"'
        expect(contents).to match(expected)
      end
    end

    context "jekyll-gist" do
      it "creates the script tag" do
        expected = '<script src="https://gist.github.com/parkr/c08ee0f2726fd0e3909d.js">'
        expect(contents).to match(expected)
      end
    end

    context "jekyll-paginate" do
      let(:file) { "index.html" }

      it "paginates" do
        expect(contents).to match("Page: 1")
        expect(contents).to match("Total Pages: 1")
      end
    end

    context "jekyll-coffeescript" do
      let(:file) { "jekyll-coffeescript.js" }

      it "converts to JS" do
        expect(path).to be_an_existing_file
        expected = Regexp.escape 'console.log("hello world");'
        expect(contents).to match(expected)
      end
    end

    context "jekyll-seo-tag" do
      it "outputs the tag" do
        expect(contents).to match("<title>Jekyll SEO Tag")
      end
    end

    context "jekyll-github-metadata" do
      it "builds the site.github namespace" do
        expect(contents).to match("Branch: gh-pages")
      end
    end

    context "jekyll-avatar" do
      it "renders the avatar" do
        expected = %r{https://avatars\d\.githubusercontent\.com/hubot\?v=3&s=40}
        expect(contents).to match(expected)
      end
    end

    context "jemoji" do
      it "renders emoji" do
        expect(contents).to match('<img class="emoji" title=":tada:" alt=":tada:"')
      end
    end

    context "jekyll-mentions" do
      it "renderse mentions" do
        expect(contents).to match('<a href="https://github.com/jekyll" class="user-mention">@jekyll</a>')
      end
    end

    context "jekyll-relative-links" do
      it "converts relative links" do
        expect(contents).to match('<a href="/jekyll.html">Jekyll</a>')
      end
    end

    context "jekyll-optional-front-matter" do
      it "renders pages without front matter" do
        expect(path).to be_an_existing_file
        expected = '<h1 id="file-without-front-matter">File without front matter</h1>'
        expect(contents).to match(expected)
      end
    end

    context "jekyll-titles-from-headings" do
      it "pulls titles from headings" do
        expect(contents).to match("The page title is “First heading”")
      end
    end

    context "jekyll-default-layout" do
      it "sets the default layout" do
        expect(contents).to match("This page’s layout is “page”")
      end
    end

    context "jekyll-readme-index" do
      let(:file) { "jekyll-readme-index/index.html" }

      it "uses the README as the index" do
        expect(path).to be_an_existing_file
        expect(contents).to match("README")
      end
    end

    context "jekyll-theme-primer" do
      it "sets the theme" do
        expect(contents).to match("Theme: jekyll-theme-primer")
      end

      it "uses the theme" do
        expect(contents).to match('<div class="container-lg px-3 my-5 markdown-body">')
      end
    end

    context "jekyll-octicons" do
      it "plops in the octicon" do
        expect(contents).to match('<svg height="32"')
        expect(contents).to match('class="octicon octicon-alert right left"')
        expect(contents).to match('aria-label="hi"')
      end
    end
  end

  context "fixture site with remote theme config" do
    before(:all) do
      rm_destination
      bundle_install
      build(["--config", "_config_with_remote_theme.yml"])
    end

    context "jekyll-remote-theme" do
      it "builds with a remote theme" do
        expect(contents).to match("remote_theme: pages-themes/cayman")
        expect(contents).to match("theme: cayman")
        expect(contents).to match('<h1 class="project-name">pages-gem</h1>')
      end
    end
  end

  context "jekyll-commonmark-ghpages" do
    before(:all) do
      rm_destination
      bundle_install
      build(["--config", "_config_with_gfm.yml"])
    end

    it "builds with GFM" do
      expect(contents).to match("markdown: CommonMarkGhPages")
    end
  end
end
