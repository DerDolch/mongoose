require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stories/new" do
  include StoriesHelper
  
  before(:each) do

    @story = Story.new
    
    @sprnt1 = mock_model(Sprint, :id => 1, :title => 'My Sprint', :start_date => Time.now, :end_date => Time.now)
    @sprnt2 = mock_model(Sprint, :id => 1, :title => 'My Sprint', :start_date => Time.now, :end_date => Time.now)

    @p1 = mock_model(Product, :id => 85, :name => 'MyName', :description => 'MyDescr', :identifier => 'DESC',
    :sprint_id => 1, :sprints => [@sprnt1, @sprnt2])   

    assigns[:story] = @story
    assigns[:product] = @p1


  end

  def do_render
    render "/stories/new"
  end

  it "should render new form" do
    do_render
    
    response.should have_tag("form[method=post]") do
      with_tag("input#story_title[name=?]", "story[title]")
      with_tag("input#story_effort[name=?]", "story[effort]")
      with_tag("textarea#story_description[name=?]", "story[description]")
      with_tag("input#story_product_id[name=?]", "story[product_id]")
      with_tag("select#story_sprint_id[name=?]", "story[sprint_id]")
    end
  end
end


