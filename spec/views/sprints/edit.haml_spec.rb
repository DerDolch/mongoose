require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/edit" do
  include SprintsHelper
  
  before do
    @product = mock_model(Product, :name => 'MyProduct', :description => 'TestDesc', :identifier => 'PDCT' )
    @sprint = mock_model(Sprint, :title => 'MyString', :goal => 'MyText', :start_date => Time.now, 
    :end_date => Time.now, :product_id => 1, :sprint_status_id => 1, :sprint => mock_model(SprintStatus, :title => 'open'),
    :product => @product)
    
    @sss1 = mock_model(SprintStatus, :title => 'open', :id => 1)
    @sss2 = mock_model(SprintStatus, :title => 'closed', :id => 2)

    assigns[:product] = @product
    assigns[:sprint] = @sprint
    assigns[:sprint_statuses] = [@sss1, @sss2]
  end

  it "should render complete edit form" do
    render "/sprints/edit"
    
    response.should have_tag("form[action=?][method=post]", product_sprint_path(@product, @sprint)) do
      with_tag('input#sprint_title[name=?]', "sprint[title]")
      with_tag('textarea#sprint_goal[name=?]', "sprint[goal]")
      
      with_tag('input#sprint_product_id[name=?]', "sprint[product_id]")
      
      with_tag('select#sprint_start_date_1i[name=?]', "sprint[start_date(1i)]")
      with_tag('select#sprint_start_date_2i[name=?]', "sprint[start_date(2i)]")
      with_tag('select#sprint_start_date_3i[name=?]', "sprint[start_date(3i)]")
      
      with_tag('select#sprint_end_date_1i[name=?]', "sprint[end_date(1i)]")
      with_tag('select#sprint_end_date_2i[name=?]', "sprint[end_date(2i)]")
      with_tag('select#sprint_end_date_3i[name=?]', "sprint[end_date(3i)]")
      
      with_tag("select#sprint_sprint_status_id[name=?]", "sprint[sprint_status_id]")
      
      with_tag('input#sprint_submit[value=?]', "Update Sprint")
      
    end
  end
end


