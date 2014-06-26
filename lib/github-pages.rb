class GitHubPages
  VERSION = 19

  DEPENDENCIES = {
    "jekyll"               => "1.5.1",
    "kramdown"             => "1.3.1",
    "liquid"               => "2.5.5",
    "maruku"               => "0.7.0",
    "rdiscount"            => "2.1.7",
    "redcarpet"            => "2.3.0",
    "RedCloth"             => "4.2.9",
    "jemoji"               => "0.1.0",
    "jekyll-mentions"      => "0.0.9",
    "jekyll-redirect-from" => "0.3.1",
    "jekyll-sitemap"       => "0.3.0"
  }.freeze

  class << self
    # Versions used by GitHub Pages, including github-pages gem and ruby version
    # Useful for programmatically querying for the current-running version
    def versions
      gems.merge({
        "github-pages" => VERSION.to_s,
        "ruby"         => RUBY_VERSION
      })
    end

    # Jekyll and related dependency versions as used by GitHub Pages.
    # For more information see:
    # https://help.github.com/articles/using-jekyll-with-pages
    def gems
      DEPENDENCIES.keys.inject(Hash.new) { |deps, dep| deps[dep] = version_for_gem(dep); deps }
    end

    def version_env_vars
      DEPENDENCIES.keys.map { |dep| env_var_for_gem_version(dep) }
    end

    def version_for_gem(gem_name)
      ENV.fetch(env_var_for_gem_version(gem_name), DEPENDENCIES[gem_name])
    end

    def env_var_for_gem_version(gem_name)
      "PAGES_#{snake_case(gem_name)}_VERSION"
    end

    def snake_case(gem_name)
      gem_name.upcase
        .gsub(/-/, '_')
    end
  end

end
