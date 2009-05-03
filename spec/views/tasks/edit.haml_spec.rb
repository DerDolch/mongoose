require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/edit" do
  include TasksHelper
  
  before(:each) do
    @task = mock_model(Task, valid_task_attributes) 
    @task.stub!(:new_record?).and_return(true)   

    @story = mock_model(Story, valid_story_attributes)
    @product = mock_model(Product, valid_product_attributes)

    assigns[:product] = @product
    assigns[:story] = @story
    assigns[:task] = @task

  end


  def do_render
    render "/tasks/edit"
  end

  it "should render edit form" do
    do_render
    
    response.should have_tag("form[action=?][method=post]", product_story_task_path(@product, @story, @task)) do
      with_tag('input#task_title[name=?]', "task[title]")
      with_tag('textarea#task_description[name=?]', "task[description]")
      with_tag('input#task_hours[name=?]', "task[hours]")
      with_tag("select#task_status[name=?]", "task[status]")
    end
  end
end