# frozen_string_literal: true

require "spec_helper"

describe(GitHubPages) do
  it "exposes its version" do
    expect(described_class::VERSION).to be_a(Integer)
  end
end
