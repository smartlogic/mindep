require 'mindep'

class Tests; end

describe Mindep do
  let(:dep_list) {
    [:a, :b, :c]
  }
  let(:dep_revs) {
    [[3, 2, 1],
     [3, 2, 1],
     [3, 2, 1]]
  }

  let(:mindep) { Mindep.new(dep_list, dep_revs) }

  it "should return revs for any dep" do
    dep_list.each_with_index do |dep, i|
      mindep.revs(dep).should eq(dep_revs[i])
    end
  end

  it "should return the absolute min if tests pass for all revs" do
    Tests.stub!(:pass?).and_return(true)
    mindep.min.should eq(:a => 1, :b => 1, :c => 1)
  end

  it "should return the last passing rev for all revs" do
    Tests.stub!(:pass?) { |dep, rev| rev != 1 }
    mindep.min.should eq(:a => 2, :b => 2, :c => 2)
  end
end
