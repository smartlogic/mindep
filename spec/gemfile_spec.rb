require "gemfile"
require "fakefs/spec_helpers"

describe Gemfile do
  include FakeFS::SpecHelpers

  let(:gemfile) { Gemfile.new(deps) }
  let(:deps) { [a, b] }
  let(:a) { stub(:name => "a", :rev => "1.0", :next => a_next) }
  let(:a_next) { stub(:name => "a", :rev => "0.5", :next => nil) }
  let(:b) { stub(:name => "b", :rev => "2.2", :next => b_next) }
  let(:b_next) { stub(:name => "b", :rev => "2.0") }

  def gemfile_output(gemfile)
    gemfile.write
    File.read("gemfiles/minimum_dependencies")
  end

  it "should generate gemfiles" do
    actual = gemfile_output(gemfile)
    expected = %{source "https://rubygems.org"\ngem "a", "1.0"\ngem "b", "2.2"}
    actual.should eq(expected)
  end

  it "should provide the gemfile with the next lowest rev" do
    actual = gemfile_output(gemfile.next)
    expected = %{source "https://rubygems.org"\ngem "a", "0.5"\ngem "b", "2.2"}
    actual.should eq(expected)
  end

  it "should skip to the next dep when the current dep is out of revs" do
    actual = gemfile_output(gemfile.next.next)
    expected = %{source "https://rubygems.org"\ngem "a", "0.5"\ngem "b", "2.0"}
    actual.should eq(expected)
  end

  it "should not modify the gemfile when asked for the next one" do
    expect {
      gemfile.next
    }.not_to change {
      gemfile_output(gemfile)
    }
  end
end
