require "gemfile"
require "fakefs/spec_helpers"

describe Gemfile do
  include FakeFS::SpecHelpers

  let(:gemfile) { Gemfile.new(deps) }
  let(:deps) { [a, b] }
  let(:a) { stub(:name => "a", :current_rev => "1.0") }
  let(:b) { stub(:name => "b", :current_rev => "2.2") }

  it "should generate gemfiles" do
    gemfile.write
    actual = File.read("gemfiles/minimum_dependencies")
    expected = %{source "https://rubygems.org"\ngem "a", "1.0"\ngem "b", "2.2"}
    actual.should eq(expected)
  end
end
