require 'mindep'

class Tests; end

describe Mindep do
  let(:mindep) { Mindep.new(bundle) }
  let(:bundle) { stub(:deps => [a, b, c]) }
  let(:a) { stub(:revs => %w{3 2 1}) }
  let(:b) { stub(:revs => %w{3 2 1}) }
  let(:c) { stub(:revs => %w{3 2 1}) }

  it "should return the absolute min if tests pass for all revs" do
    Tests.stub!(:passing?).and_return(true)
    mindep.min.should eq(a => "1", b => "1", c => "1")
  end

  it "should return the last passing rev for all revs" do
    Tests.stub!(:passing?) { |dep, rev| rev != "1" }
    mindep.min.should eq(a => "2", b => "2", c => "2")
  end
end
