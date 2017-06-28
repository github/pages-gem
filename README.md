# GitHub Pages Ruby Gem

A simple Ruby Gem to bootstrap dependencies for setting up and maintaining a local Jekyll environment in sync with GitHub Pages.

[![Gem Version](https://badge.fury.io/rb/github-pages.svg)](https://badge.fury.io/rb/github-pages)
[![Build Status](https://img.shields.io/travis/github/pages-gem/master.svg)](https://travis-ci.org/github/pages-gem)

## Usage

**Important: Make sure you have Bundler > v1.14 by running `gem update bundler` in your terminal before following the next steps.**

1. Add the following to your project's Gemfile:  

  ```ruby
  gem 'github-pages', group: :jekyll_plugins
  ```

2. Run `bundle install`

*Note: You are not required to install Jekyll separately. Once the `github-pages` gem is installed, you can build your site using `jekyll build`, or preview your site using `jekyll serve`.* For more information about installing Jekyll locally, please see [the GitHub Help docs on the matter](https://help.github.com/articles/using-jekyll-with-pages#installing-jekyll).

### Command line usage

The GitHub Pages gem also comes with several command-line tools, contained within the `github-pages` command.

#### List dependency versions

```console
$ bundle exec github-pages versions
+---------------------------+---------+
| Gem                       | Version |
+---------------------------+---------+
| jekyll                    | x.x.x   |
| kramdown                  | x.x.x   |
| liquid                    | x.x.x   |
| ....                      | ....    |
+---------------------------+---------+
```

Note, you can also pass the `--gemfile` flag to get the dependencies listed in a valid Gemfile dependency format. You can also see a list of the live dependency versions at [pages.github.com/versions](https://pages.github.com/versions/).

#### Health check

Checks your GitHub Pages site for common DNS configuration issues.

```console
$ github-pages health-check
Checking domain foo.invalid...
Uh oh. Looks like something's fishy: A record points to deprecated IP address
```

See the [GitHub Pages Health Check](https://github.com/github/pages-health-check) documentation for more information.

### Bypassing the plugin whitelist

If you'd like to run a Jekyll plugin locally that's not whitelisted for use on GitHub Pages, you can do so by prefixing the `jekyll build` or `jekyll serve` command with `DISABLE_WHITELIST=true`. This will allow your site to use any plugin listed in your site's `gems` configuration flag. Please note, however, this option is only available when previewing your Jekyll site locally.

## Updating

To update to the latest version of Jekyll and associated dependencies, simply run `gem update github-pages`, or if you've installed via Bundler, `bundle update github-pages`.

## Project Goals

The goal of the GitHub Pages gem is to help GitHub Pages users bootstrap and maintain a Jekyll build environment that most closely matches the GitHub pages build environment. The GitHub Pages gem relies on explicit requirements shared between both users' computers and the build servers to ensure that the result of a user's local build is consistently also the result of the server's build.

Additional tools, such as tools that integrate with the GitHub API to make managing GitHub Pages sites easier are not the primary goal, but may be within the project's scope.

## What's versioned

The GitHub Pages gem seeks to version two aspects of the build environment:

### 1. Ruby

The version of Ruby with which Jekyll is executed. Although Jekyll itself may be compatible with prior or future versions of Ruby, different execution environments yield different results. Ruby 1.8.7 parses YAML differently than 1.9.3, for example, and Kramdown has trouble processing `mailto` links prior to 1.9.3. In order to ensure that building locally consistently results in the same build as what appears when published, it's essential that Ruby itself is versioned along side the Gem, despite no known incompatibilities.

### 2. Dependencies

This includes Markdown processors, and any other Jekyll dependency for which version incongruency may produce unexpected results. Traditionally, Maruku, Kramdown, RedCloth, liquid, rdiscount, and redcarpet have been strictly maintained due to known breaking changes.

## Changelog

See [all releases](https://github.com/github/pages-gem/releases).

## Releasing

To release a new version of this gem, run `script/release` from the `master` branch.

## License

Distributed under the [MIT License](LICENSE).
