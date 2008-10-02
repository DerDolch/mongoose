require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sprint do
  before(:each) do
    @sprint = Sprint.new(:title=>"blah", :goal=>"hello", :start_date=>Date.new, :end_date=>Date.new, :sprint_status_id => 1)
  end

  it "should be valid" do
    @sprint.should be_valid
  end
end
