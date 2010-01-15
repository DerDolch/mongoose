require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Release do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :start_at => Date.today,
      :release_at => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    Release.create!(@valid_attributes)
  end
end
