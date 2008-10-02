require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/stories/index" do
  include StoriesHelper
  
  before(:each) do
    story_98 = mock_model(Story)
    story_98.should_receive(:title).and_return("MyString")
    story_98.should_receive(:effort).and_return("1")
    story_98.should_receive(:description).and_return("MyText")
    story_98.should_receive(:product_id).and_return("1")
    story_99 = mock_model(Story)
    story_99.should_receive(:title).and_return("MyString")
    story_99.should_receive(:effort).and_return("1")
    story_99.should_receive(:description).and_return("MyText")
    story_99.should_receive(:product_id).and_return("1")

    assigns[:stories] = [story_98, story_99]
    
    @p1 = mock_model(Product, :name => 'Scrum', :description => 'My Scrum', :identifier => 'MS')
    @p2 = mock_model(Product, :name => 'TextMate', :description => 'My Editor', :identifier => 'TXTMT')
    assigns[:product] = [@p1,@p2]
  end

  it "should render list of stories" do
    render "/stories/index"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end

