require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Task do
  before(:each) do
    @task = Task.new(:title=>"hello ", :description=>"world", :hours=>"12", :status=>"Active" )
  end

  it "should be valid" do
    @task.should be_valid
  end

end
