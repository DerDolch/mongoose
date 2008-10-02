require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/index" do
  include TasksHelper
  
  before(:each) do
    @task_1 = mock_model(Task, :title => 'My String', :description => 'MyText', :hours => 1, :task_status_id => 1,
    :task_status => mock_model(TaskStatus, :id => 1, :name=>"Done"))


    @task_2 = mock_model(Task, :title => 'My String', :description => 'MyText', :hours => 1, :task_status_id => 1,
    :task_status => mock_model(TaskStatus, :id => 1, :name=>"Done"))


    @p1 = mock_model(Story, :title => 'MyString', :effort => '1', :description => 'MyText', :product_id => 2)
    @s1 = mock_model(Product, :id => 85, :name => 'MyName', :description => 'MyDescr', :identifier => 'DESC')

    assigns[:product] = @p1
    assigns[:story] = @s1

    assigns[:tasks] = [@task_1, @task_2]
  end

  def do_render
    render "/tasks/index"
  end

  # it "should invalidate if @tasks is empty"

  it "should render list of tasks" do
    do_render

    response.should have_tag("table tbody") do
      response.should have_tag("tr td", 'My String', 2)
      response.should have_tag("tr td", 'MyText', 2)
      response.should have_tag("tr td", '1', 2)
      response.should have_tag('a', 'Show', 2)
      response.should have_tag('a', 'Edit', 2)
      response.should have_tag('a', 'Remove', 2)
    end

  end

  it "should have a link to create a new tasks" do
    do_render   
    response.should have_tag("a[href=#{new_product_story_task_path(@p1, @s1)}]", 'New Task')
  end

end

