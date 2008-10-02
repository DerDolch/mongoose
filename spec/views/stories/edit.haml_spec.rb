require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stories/edit" do
  include StoriesHelper
  
  before do

    @sprnt1 = mock_model(Sprint, :id => 1, :title => 'My Sprint', :start_date => Time.now, :end_date => Time.now, :sprint_status_id => 1)
    @sprnt2 = mock_model(Sprint, :id => 1, :title => 'My Sprint', :start_date => Time.now, :end_date => Time.now, :sprint_status_id => 1)
    @sprints = [@sprnt1, @sprnt2]
    @active_sprints = [@sprnt1, @sprnt2]

    @story = mock_model(Story, :title => 'MyString', :effort => '2', :description => 'MyText', :product_id => 1, :sprint_id => 1,
    :sprint => mock_model(Sprint, :title => 'MyString', :goal => 'MyText', :start_date => Time.now, 
    :end_date => Time.now, :product_id => 1, :sprint_status_id => 1))

    @product = mock_model(Product, :id => 85, :name => 'MyName', :description => 'MyDescr', :identifier => 'DESC',
    :sprint_id => 1, :sprints => [@sprnt1, @sprnt2], :product_status_id => 1, :product_status => mock_model(ProductStatus, :id => 1, :title => 'Active'))   
    @product.stub!(:sprints).and_return(@sprints)
    @sprints.stub!(:active_sprints).and_return(@active_sprints)
    
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


