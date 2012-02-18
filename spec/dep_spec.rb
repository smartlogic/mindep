require "dep"

describe Dep do
  let(:dep) { Dep.new("name") }
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

  it "should return the latest rev as the default current rev" do
    dep.current_rev.should eq("3")
  end

  it "should decrement the rev" do
    dep.downgrade!
    dep.current_rev.should eq("2")
  end
end
