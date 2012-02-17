require "dep"
require "json"
require "webmock/rspec"

describe Dep do
  let(:dep) { Dep.new("gem_name") }
  let(:versions_resource) {
    [{"number" => "3"},
     {"number" => "2"},
     {"number" => "1"}]
  }
  
  before do
    stub_request(:get, "https://rubygems.org/api/v1/versions/gem_name.yaml").
      to_return(:body => JSON.generate(versions_resource))
  end

  it "should return all revisions for a dep" do
    dep.revs.should eq(%w{3 2 1})
  end
end
