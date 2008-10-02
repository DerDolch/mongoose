require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/show" do
  include SprintsHelper
  
  before(:each) do
    @sprint = mock_model(Sprint, :title => 'MyString', :goal => 'MyText', :start_date => Time.now, :end_date => Time.now,
    :sprint_status_id => 1, :sprint_status => mock_model(SprintStatus, :title => 'open', :id => 1))
    @p1 = mock_model(Product, :id => 85, :name => 'MyName', :description => 'MyDescr', :identifier => 'DESC', :product_status_id => 1,
    :product_status => mock_model(ProductStatus, :id => 1, :title => 'Active')) 
    assigns[:sprint] = @sprint
    assigns[:product] = @p1
  end

  it "should render attributes in <p>" do
    render "/sprints/show"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

