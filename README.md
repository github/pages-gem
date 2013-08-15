# GitHub Pages Ruby Gem

A simple Ruby Gem to bootstrap dependencies for setting up and maintaining a local Jekyll environment in sync with GitHub Pages.

[![Gem Version](https://badge.fury.io/rb/github-pages.png)](http://badge.fury.io/rb/github-pages)

## Usage

Run the following command:

`gem install github-pages`

Alternatively, you can add the following to your project's Gemfile:

`gem 'github-pages'`

*Note: You are not required to install Jekyll separately. Once the `github-pages` gem is installed, you can build your site using `jekyll build`, or preview your site using `jekyll serve`.*

## Updating

To update to the latest version of Jekyll and associated dependencies, simply run `gem update github-pages`, or if you've installed via Bundler, `bundle update github-pages`.

## Project Goals

The goal of the GitHub Pages gem is to help GitHub Pages users bootstrap and maintain a Jekyll build environment that most closely matches the GitHub pages build environment. The GitHub Pages gem relies on explicit requirements shared between both users' computers and the build servers to ensure that the result of a user's local build is consistently also the result of the server's build.

Additional tools, such as tools that integrate with the GitHub API to make managing GitHub Pages sites easier are not the primary goal, but may be within the project's scope.

## What's versioned

The GitHub Pages gem seeks to version two aspects of the build environment:

1. Ruby

The version of Ruby with which Jekyll is executed. Although Jekyll itself may be compatible with prior or future versions of Ruby, different execution environments yield different results. Ruby 1.8.7 parses YML differently than 1.9.3, for example, and Kramdown has trouble processing `mailto` links prior to 1.9.3. In order to ensure that building locally consistently results in a the same build as what appears when published, it's essential that Ruby itself is versioned along side the Gem, despite no known incompatibilities.

2. Dependencies

This includes Markdown processors, and any other Jekyll dependency for which version inconguency may produce unexpected results. Traditionally, MaruKu, Kramdown, RedCloth, liquid, rdiscount, and redcarpet have been strictly maintained due to known breaking changes.

## Releasing

To release a new version of this gem, run `script/release` from the `master` branch.

## License

Distributed under the [MIT License](LICENSE).
