require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TaskStatus do
  before(:each) do
    @task_status = TaskStatus.new
  end

  it "should be valid" do
    @task_status.should be_valid
  end
end
