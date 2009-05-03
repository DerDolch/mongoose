require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stories/show" do
  include StoriesHelper
  
  before(:each) do

    @product = mock_model(Product, valid_product_attributes)
    @story = mock_model(Story, valid_story_attributes)

    @ts1 = mock_model(Task, valid_task_attributes)
    @ts2 = mock_model(Task, valid_task_attributes(:hours => 5))
    
    assigns[:product] = @product
    assigns[:story] = @story
    assigns[:tasks] = [@ts1, @ts2]
    
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
    response.should have_tag('tbody>tr>td', @ts1.hours.to_s)
    response.should have_tag("tbody>tr>td a[href=?]", edit_product_story_task_path(@product, @story, @ts1), 'Edit')
    response.should have_tag("tbody>tr>td a[href=?][onclick]", product_story_task_path(@product, @story, @ts1), 'Remove')

    # ts2
    response.should have_tag("tbody>tr>td a[href=?]", product_story_task_path(@product, @story, @ts2), @ts2.title)
    response.should have_tag('tbody>tr>td', @ts2.description)
    response.should have_tag('tbody>tr>td', @ts2.hours.to_s)
    response.should have_tag("tbody>tr>td a[href=?]", edit_product_story_task_path(@product, @story, @ts2), 'Edit')
    response.should have_tag("tbody>tr>td a[href=?][onclick]", product_story_task_path(@product, @story, @ts2), 'Remove')
    
  end

end

