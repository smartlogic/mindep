require "dep"

describe Dep do
  let(:dep) { Dep.new("gem_name") }
  let(:versions_resource) {
    [{"number" => "3"},
     {"number" => "2"},
     {"number" => "1"}]
  }
  
  it "should return all revisions for a dep" do
    Gems.stub!(:versions).with("gem_name").and_return(versions_resource)
    dep.revs.should eq(%w{3 2 1})
  end
end
