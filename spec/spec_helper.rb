# frozen_string_literal: true
require File.expand_path("../../lib/github-pages.rb", __FILE__)

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def fixture_dir
  File.expand_path "./fixtures", File.dirname(__FILE__)
end

def tmp_dir
  File.expand_path "./test-site", File.dirname(__FILE__)
end
