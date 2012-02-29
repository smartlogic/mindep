require "bundle"
require "fakefs/spec_helpers"

class Dep; end

describe Bundle do
  include FakeFS::SpecHelpers

  let(:dep) { stub(:name => "activesupport", :current_rev => "1.0") }

  before do
    File.open("Gemfile", "w+") do |f|
      f.puts 'source "https://rubygems.org"'
      f.puts 'gem "activesupport"'
    end

    Dep.stub!(:new).with("activesupport").and_return(dep)
  end

  it "should return a list of deps" do
    Bundle.deps.should eq([dep])
  end
end
