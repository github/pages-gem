# Contributing to the GitHub Pages Gem

## Where to get help or report an issue

### Bugs

* If your think you may have found a bug in a particular plugin, please open an issue against that plugin's repository directly.

* If your think you may have found a bug in Jekyll itself, please [open an issue in the Jekyll repository](https://github.com/jekyll/jekyll/issues/new).

* If you think you may have found a bug with how the GitHub Pages Gem bootstraps your local development environment, please [open an issue in this repository](https://github.com/github/pages-gem/issues/new).

### Questions

If you have a general question about Jekyll or GitHub Pages (e.g., a configuration question, a question specific to your site, upgrading, etc.) you have two options:

1. [Contact GitHub Support](https://github.com/contact?form%5Bsubject%5D=GitHub%20Pages), or

2. Ask your question of the Jekyll community on [talk.jekyllrb.com](https://talk.jekyllrb.com/)

### Feature requests

General GitHub Pages feature requests, including requests to add additional plugins should be made via [GitHub Support](https://github.com/contact?form%5Bsubject%5D=GitHub%20Pages%20Feature%20Request).

## Contributing

Interested in contributing? Great. We'd love you to. Before contributing be sure to read and understand [the project goals](https://github.com/github/pages-gem/blob/master/README.md#project-goals).

## How to contribute

1. Fork the project
2. Create a new, descriptively named branch
3. Commit your proposed changes
4. Submit a pull request

## Testing with Bundler

To test your Gem with [Bundler](http://bundler.io), you can:

1. Create a directory
2. Add a `Gemfile` like the following:

    ```ruby
    gem 'github-pages', :git => 'https://github.com/<you>/pages-gem.git', :branch => '<your branch name>', :require => 'gh-pages'
    ```

3. Execute `bundle install`
4. Test
