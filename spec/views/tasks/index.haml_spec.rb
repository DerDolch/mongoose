require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tasks/index" do
  include TasksHelper
  
  before(:each) do
    @task = mock_model(Task, valid_task_attributes)

    @story = mock_model(Story, valid_story_attributes)
    @product = mock_model(Product, valid_product_attributes)

    assigns[:product] = @product
    assigns[:story] = @story

    assigns[:tasks] = [@task, @task]
  end

  def do_render
    render "/tasks/index"
  end

  # it "should invalidate if @tasks is empty"

  it "should render list of tasks" do
    do_render

    response.should have_tag("table tbody") do
      response.should have_tag("tr td", @task.title, 2)
      response.should have_tag("tr td", @task.description, 2)
      response.should have_tag("tr td", @task.status, 2)
      response.should have_tag('a', 'Show', 2)
      response.should have_tag('a', 'Edit', 2)
      response.should have_tag('a', 'Remove', 2)
    end

  end

  it "should have a link to create a new tasks" do
    do_render   
    response.should have_tag("a[href=#{new_product_story_task_path(@product, @story)}]", 'New Task')
  end

end

