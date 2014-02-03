require 'spec_helper'

describe(GitHubPages) do
  it "exposes its version" do
    expect(described_class::VERSION).to be_a(Fixnum)
  end

  it "exposes its gem versions" do
    expect(described_class.gems).to be_a(Hash)
  end

  it "exposes relevant versions of dependencies, self and Ruby" do
    expect(described_class.versions).to be_a(Hash)
    expect(described_class.versions).to include("ruby")
    expect(described_class.versions).to include("github-pages")
  end

  %w[jekyll kramdown liquid maruku rdiscount redcarpet RedCloth].each do |gem|
    it "exposes #{gem} dependency version" do
      expect(described_class.gems[gem]).to be_a(String)
      expect(described_class.gems[gem]).not_to be_empty
    end
  end
end
