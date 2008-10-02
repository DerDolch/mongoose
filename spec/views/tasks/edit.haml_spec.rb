require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/edit" do
  include TasksHelper
  
  before(:each) do
    @task = mock_model(Task, :story_id => 1, :title => "title", :description =>"desc", 
    :hours => 1, :task_status_id => 1, :task_status => mock_model(TaskStatus, :id => 1, :name=>"Done"))    
    @tsess = [mock_model(TaskStatus, :name => "Ready", :id => 1), mock_model(TaskStatus, :name => "Not Ready", :id => 2)]

    @p1 = mock_model(Story, :title => 'MyString', :effort => '1', :description => 'MyText', :product_id => 2)
    @s1 = mock_model(Product, :id => 85, :name => 'MyName', :description => 'MyDescr', :identifier => 'DESC')

    assigns[:product] = @p1
    assigns[:story] = @s1

    assigns[:task] = @task
    assigns[:task_statuses] = @tsess

  end


  def do_render
    render "/tasks/edit"
  end

  it "should render edit form" do
    do_render
    
    response.should have_tag("form[action=?][method=post]", product_story_task_path(@p1, @s1, @task)) do
      with_tag('input#task_title[name=?]', "task[title]")
      with_tag('textarea#task_description[name=?]', "task[description]")
      with_tag('input#task_hours[name=?]', "task[hours]")
      with_tag("select#task_task_status_id[name=?]", "task[task_status_id]")
    end
  end
end