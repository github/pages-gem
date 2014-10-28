require 'spec_helper'

describe(GitHubPages) do
  it "lists the dependency versions" do
    output = `github-pages versions`
    expect(output).to include("Gem")
    expect(output).to include("Version")
    GitHubPages.gems.each do |name, version|
      expect(output).to include("| #{name}")
      expect(output).to include("| #{version}")
    end
  end

  it "outputs the branch" do
    expect(`github-pages branch`).to eql("gem 'github-pages', :branch => 'master', :git => 'git://github.com/github/pages-gem'\n")
  end

  it "detects the CNAME when running health check" do
    File.write("CNAME", "foo.invalid")
    expect(`github-pages health-check`).to include("Checking domain foo.invalid...")
    File.delete("CNAME")
  end
end
