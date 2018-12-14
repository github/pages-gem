# frozen_string_literal: true

require File.expand_path("../lib/github-pages.rb", __dir__)
require "open3"
require "webmock/rspec"

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Stub all GitHub API requests so they come back empty.
  config.before(:each) do
    stub_request(:get, /api.github.com/)
      .to_return(:status => 200, :body => "{}", :headers => {})
  end
end

def fixture_dir
  File.expand_path "fixtures", __dir__
end

def tmp_dir
  File.expand_path "../tmp", __dir__
end

RSpec::Matchers.define :be_an_existing_file do
  match { |path| File.exist?(path) }
end
