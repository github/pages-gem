# Contributing to The GitHub Pages Gem

Hi there! We're thrilled that you'd like to contribute to The GitHub Pages Gem. Your help is essential for keeping it great.

The GitHub Pages Gem is an open source project supported by the efforts of an entire community and built one contribution at a time by users like you. We'd love for you to get involved. Whatever your level of skill or however much time you can give, your contribution is greatly appreciated. There are many ways to contribute, from writing tutorials or blog posts, improving the documentation, submitting bug reports and feature requests, helping other users by commenting on issues, or writing code which can be incorporated into The GitHub Pages Gem itself.

Following these guidelines helps to communicate that you respect the time of the developers managing and developing this open source project. In return, they should reciprocate that respect in addressing your issue, assessing changes, and helping you finalize your pull requests.

## Looking for support?

We'd love to help. Check out [the support guidelines](SUPPORT.md).

## How to report a bug

Think you found a bug? Please check [the list of open issues](https://github.com/github/pages-gem/issues) to see if your bug has already been reported. If it hasn't please [submit a new issue](https://github.com/github/pages-gem/issues/new).

Here are a few tips for writing *great* bug reports:

* Complete the template provided on the new issue form
* Describe the specific problem (e.g., "widget doesn't turn clockwise" versus "getting an error")
* Include the steps to reproduce the bug, what you expected to happen, and what happened instead
* Check that you are using the latest version of the project and its dependencies
* Include what version of the project your using, as well as any relevant dependencies
* Only include one bug per issue. If you have discovered two bugs, please file two issues
* Even if you don't know how to fix the bug, including a failing test may help others track it down

**If you find a security vulnerability, do not open an issue. Please email security@github.com instead.**

## How to suggest a feature or enhancement

General GitHub Pages feature requests, including requests to add additional plugins or themes should be made via [GitHub Support](https://github.com/contact?form%5Bsubject%5D=GitHub%20Pages%20Feature%20Request).

Generally, requests for additional plugins are only considered if:

* The plugin is useful for a vast majority of users
* The plugin is available as a gem
* The plugin is covered with an extensive test suite
* The plugin is actively maintained

## Your first contribution

We'd love for you to contribute to the project. Unsure where to begin contributing to The GitHub Pages Gem? You can start by looking through these "good first issue" and "help wanted" issues:

* [Good first issues](https://github.com/github/pages-gem/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22) - issues which should only require a few lines of code and a test or two
* [Help wanted issues](https://github.com/github/pages-gem/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22) - issues which may be a bit more involved, but are specifically seeking community contributions

*p.s. Feel free to ask for help; everyone is a beginner at first* :smiley_cat:

## How to propose changes

Here's a few general guidelines for proposing changes:

* If you are changing any user-facing functionality, please be sure to update the documentation
* Each pull request should implement **one** feature or bug fix. If you want to add or fix more than one thing, submit more than one pull request
* Do not commit changes to files that are irrelevant to your feature or bug fix
* Don't bump the version number in your pull request (it will be bumped prior to release)
* Write [a good commit message](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)

At a high level, [the process for proposing changes](https://guides.github.com/introduction/flow/) is:

1. [Fork](https://github.com/github/pages-gem/fork) and clone the project
2. Configure and install the dependencies: `script/bootstrap`
3. Make sure the tests pass on your machine: `script/cibuild`
4. Create a new branch: `git checkout -b my-branch-name`
5. Make your change, add tests, and make sure the tests still pass
6. Push to your fork and [submit a pull request](https://github.com/github/pages-gem/compare)
7. Pat your self on the back and wait for your pull request to be reviewed and merged

**Interesting in submitting your first Pull Request?** It's easy! You can learn how from this *free* series [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

## Bootstrapping your local development environment

`script/bootstrap`

## Running tests

`script/cibuild`

## Testing with Bundler

To test your Gem with [Bundler](http://bundler.io), you can:

1. Create a directory
2. Add a `Gemfile` like the following:

    ```ruby
    gem 'github-pages', :git => 'https://github.com/<you>/pages-gem.git', :branch => '<your branch name>', :require => 'gh-pages'
    ```

3. Execute `bundle install`
4. Test

## Code of conduct

This project is governed by [the Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Additional Resources

* [Contributing to Open Source on GitHub](https://guides.github.com/activities/contributing-to-open-source/)
* [Using Pull Requests](https://help.github.com/articles/using-pull-requests/)
* [GitHub Help](https://help.github.com)
