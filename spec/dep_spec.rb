require "dep"

describe Dep do
  let(:dep) { Dep.new("name", rev) }
  let(:rev) { nil }
  let(:versions_resource) {
    [{"number" => "3"},
     {"number" => "2"},
     {"number" => "1"}]
  }

  before do
    Gems.stub!(:versions).with("name").and_return(versions_resource)
  end

  it "should return the name" do
    dep.name.should eq("name")
  end
  
  it "should return all revisions for a dep" do
    dep.revs.should eq(%w{3 2 1})
  end

  it "should cache the revs to avoid slowness" do
    dep.revs.should equal(dep.revs)
  end

  it "should return the latest rev as the default rev" do
    dep.rev.should eq("3")
  end

  context "when the rev is set" do
    let(:rev) { "2" }

    it "should return the rev" do
      dep.rev.should eq("2")
    end
  end

  it "should provide the dep with the next lowest rev" do
    dep.next.rev.should eq("2")
  end

  it "should stop returning the next dep if there are no more revs" do
    dep.next.next.next.should eq(nil)
  end
end
