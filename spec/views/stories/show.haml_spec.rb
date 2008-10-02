require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stories/show" do
  include StoriesHelper
  
  before(:each) do

    @product = mock_model(Product, :name => 'TestProd', :description => 'TestDescProd', :identifier => 'Test123',
    :product_status_id => 1, :product_status => mock_model(ProductStatus, :id => 1, :title => 'Active'))
    @story = mock_model(Story, :title => 'MyString', :effort => '1', :description => 'MyText', :product_id => 2)

    @ts1 = mock_model(Task, :story_id => 1, :title => "title", :description =>"desc", 
    :hours => '1', :task_status_id => 1, :task_status => mock_model(TaskStatus, :id => 1, :name=>"Done"))

    @ts2 = mock_model(Task, :story_id => 1, :title => "title", :description =>"desc", 
    :hours => '1', :task_status_id => 1, :task_status => mock_model(TaskStatus, :id => 2, :name=>"Done"))
    
    @tsess = [mock_model(TaskStatus, :name => "Ready", :id => 1), mock_model(TaskStatus, :name => "Not Ready", :id => 2)]

    @task_status

    assigns[:product] = @product
    assigns[:story] = @story
    assigns[:tasks] = [@ts1, @ts2]
    assigns[:task_statuses] = @tsess
    
  end

  def do_render
    render "/stories/show"    
  end

  it "should have a link back to the product you are under in the hierarchy" do
    do_render
  end
  
  it "should display a description of a given story along with how much effort is required" do
    do_render
    response.should have_tag('p>strong', "Effort: #{@story.effort}")
    response.should have_text(/#{@story.description}/)
  end

  it "should render a message if there are no tasks listed" do
    assigns[:tasks] = []
    do_render
    # response.should have_tag('h3', 'No tasks listed for this story.')  
  end

  it "should render a table with all tasks inside of it" do
  
    do_render

    # ts1
    response.should have_tag("tbody>tr>td a[href=?]", product_story_task_path(@product, @story, @ts1), @ts1.title)
    response.should have_tag('tbody>tr>td', @ts1.description)
    response.should have_tag('tbody>tr>td', @ts1.hours)
    response.should have_tag("tbody>tr>td a[href=?]", edit_product_story_task_path(@product, @story, @ts1), 'Edit')
    response.should have_tag("tbody>tr>td a[href=?][onclick]", product_story_task_path(@product, @story, @ts1), 'Remove')

    # ts2
    response.should have_tag("tbody>tr>td a[href=?]", product_story_task_path(@product, @story, @ts2), @ts2.title)
    response.should have_tag('tbody>tr>td', @ts2.description)
    response.should have_tag('tbody>tr>td', @ts2.hours)
    response.should have_tag("tbody>tr>td a[href=?]", edit_product_story_task_path(@product, @story, @ts2), 'Edit')
    response.should have_tag("tbody>tr>td a[href=?][onclick]", product_story_task_path(@product, @story, @ts2), 'Remove')
    
  end

end

