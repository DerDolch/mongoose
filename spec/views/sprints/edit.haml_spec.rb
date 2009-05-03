require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/edit" do
  include SprintsHelper
  
  before do
    @product = mock_model(Product, valid_product_attributes )
    @sprint = mock_model(Sprint, valid_sprint_attributes)

    assigns[:product] = @product
    assigns[:sprint] = @sprint
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
      
      with_tag("select#sprint_status[name=?]", "sprint[status]")
      
      with_tag('input#sprint_submit[value=?]', "Update Sprint")
      
    end
  end
end


