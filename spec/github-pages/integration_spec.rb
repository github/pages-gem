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

  def env
    {
      "BUNDLE_GEMFILE" => "#{source}/Gemfile",
      "JEKYLL_ENV"     => "development",
    }
  end

  let(:file) { "#{self.class.description}.html" }
  let(:path) { destination_file file }
  let(:contents) { File.read path }

  before(:all) do
    FileUtils.rm_rf(destination)
    Dir.chdir(source) do
      bundle_output, status = Open3.capture2e env, %w(bundle install)
      raise StandardError, bundle_output if status.exitstatus != 0
      cmd = %w(bundle exec jekyll build --verbose)
      cmd = cmd.concat ["--source", source, "--destination", destination]
      build_output, status = Open3.capture2e env, *cmd
      raise StandardError, bundle_output + build_output if status.exitstatus != 0
    end
  end
  after(:all) { FileUtils.rm_rf(destination) }

  it "tests all dependencies" do
    contents = File.read(__FILE__)
    contexts = contents.scan(/context \"(.*?)\"/)
    missing = GitHubPages::Dependencies::VERSIONS.keys - contexts.flatten
    missing -= %w(listen activesupport github-pages-health-check)
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
      expected << '<pre class="highlight"><code><span class="nb">'
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
end
