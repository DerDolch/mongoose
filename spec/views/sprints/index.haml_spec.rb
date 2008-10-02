require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/index" do
  include SprintsHelper
  
  before(:each) do
    @s1 = mock_model(Sprint, :title => 'MyString', :goal => 'MyText', :start_date => Time.now, 
    :end_date => Time.now, :product_id => 1, :sprint_status_id => 1, :sprint_status => mock_model(SprintStatus, :title => 'open', :id => 1),
    :product => mock_model(Product, :name => 'MyProduct', :description => 'TestDesc', :identifier => 'PDCT' ))

    @s2 = mock_model(Sprint, :title => 'MyString', :goal => 'MyText', :start_date => Time.now, 
    :end_date => Time.now, :product_id => 1, :sprint_status_id => 2, :sprint_status => mock_model(SprintStatus, :title => 'open', :id => 2),
    :product => mock_model(Product, :name => 'MyProduct', :description => 'TestDesc', :identifier => 'PDCT' ))

    @p1 = mock_model(Product, :id => 85, :name => 'MyName', :description => 'MyDescr', :identifier => 'DESC', :product_status_id => '1', :product_status => mock_model(ProductStatus, :id => 1, :title => "Active"))

    assigns[:sprints] = [@s1, @s2]
    assigns[:product] = @p1
  end

  it "should render list of sprints" do
    render "/sprints/index"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end

