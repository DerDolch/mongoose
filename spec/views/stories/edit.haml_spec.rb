require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stories/edit" do
  include StoriesHelper
  
  before do

    @sprint = mock_model(Sprint,valid_sprint_attributes)
    @sprints_proxy = mock('SprintsProxy', :active => [@sprint])
    
    @story = mock_model(Story,valid_story_attributes)
    @product = mock_model(Product)
    @product.stub!(:sprints).and_return(@sprints_proxy)

    assigns[:story] = @story
    assigns[:product] = @product

  end

  it "should render complete edit form" do
    render "/stories/edit"
    
    response.should have_tag("form[action=?][method=post]", product_story_path(@product, @story)) do
      with_tag('input#story_title[name=?]', "story[title]")
      with_tag('input#story_effort[name=?]', "story[effort]")
      with_tag('textarea#story_description[name=?]', "story[description]")
      with_tag('select#story_sprint_id[name=?]', "story[sprint_id]")
      with_tag('input#story_submit[value=?]', "Update Story")   
    end
  end
end


