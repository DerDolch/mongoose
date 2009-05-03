require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/index" do
  include SprintsHelper
  
  before(:each) do
    @s1 = mock_model(Sprint, valid_sprint_attributes)

    @s2 = mock_model(Sprint, valid_sprint_attributes)

    @p1 = mock_model(Product, valid_product_attributes)

    assigns[:sprints] = [@s1, @s2]
    assigns[:product] = @p1
  end

  it "should render list of sprints" do
    render "/sprints/index"
    response.should have_tag("tr>td", @s1.title, 2)
    response.should have_tag("tr>td", @s1.goal, 2)
  end
end

