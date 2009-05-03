require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/show" do
  include SprintsHelper
  
  before(:each) do
    @sprint = mock_model(Sprint, valid_sprint_attributes)
    @p1 = mock_model(Product, valid_product_attributes) 
    assigns[:sprint] = @sprint
    assigns[:product] = @p1
  end

  it "should render attributes in <p>" do
    render "/sprints/show"
    response.should have_tag("h2", @sprint.title)
    response.should have_text(/#{@sprint.goal}/)
  end
end

