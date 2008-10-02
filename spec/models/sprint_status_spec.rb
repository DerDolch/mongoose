require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SprintStatus do
  before(:each) do
    @sprint_status = SprintStatus.new
  end

  it "should be valid" do
    @sprint_status.should be_valid
  end
end
