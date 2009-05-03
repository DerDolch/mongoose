require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/show" do
  include TasksHelper
  
  before(:each) do
    @task = mock_model(Task, valid_task_attributes)    

    @story = mock_model(Story, valid_story_attributes)
    @product = mock_model(Product, valid_product_attributes)

    assigns[:task] = @task
    assigns[:product] = @product
    assigns[:story] = @story

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

