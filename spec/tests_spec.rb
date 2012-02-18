require "tests"

describe Tests do
  it "tells you if the tests pass" do
    Tests.stub!(:system).with("bundle exec rake").and_return(true)
    Tests.should be_passing
  end

  it "tells you if the tests fail" do
    Tests.stub!(:system).with("bundle exec rake").and_return(false)
    Tests.should_not be_passing
  end
end
