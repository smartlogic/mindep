require "bundle"
require "fakefs/spec_helpers"

describe Bundle do
  include FakeFS::SpecHelpers

  let(:bundle) { Bundle.new }

  before do
    File.open("Gemfile", "w+") do |f|
      f.puts 'source "https://rubygems.org"'
      f.puts 'gem "a"'
      f.puts 'gem "b"'
      f.puts 'gem "c"'
    end
  end

  it "should return a list of deps" do
    bundle.deps.should eq(["a", "b", "c"])
  end
end
