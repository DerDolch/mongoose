require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/show" do
  include TasksHelper
  
  before(:each) do
    @task = mock_model(Task, :story_id => 1, :title => "title", :description =>"desc",
    :hours => 1, :task_status => mock_model(TaskStatus, :name=>"Completed"))    

    @p1 = mock_model(Story, :title => 'MyString', :effort => '1', :description => 'MyText', :product_id => 2)
    @s1 = mock_model(Product, :id => 85, :name => 'MyName', :description => 'MyDescr', :identifier => 'DESC')

    assigns[:task] = @task
    assigns[:product] = @p1
    assigns[:story] = @s1

  end

  def do_render
    render "/tasks/show"
  end
  
  it "should be successful" do
    do_render
    response.should be_success
  end
  
  it "should render attributes in <p>" do
    do_render
    response.should have_text(/title/)
    response.should have_text(/desc/)
    response.should have_text(/1/)
  end
  
  it "should have a task status" do
    do_render
    response.should have_tag('p#task_status strong')
  end
end

