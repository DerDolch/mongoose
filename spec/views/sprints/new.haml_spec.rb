require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/sprints/new" do
  include SprintsHelper
  
  before(:each) do
    @sprint = Sprint.new
    @p1 = mock_model(Product, :id => 85, :name => 'MyName', :description => 'MyDescr', :identifier => 'DESC')
    @sss1 = mock_model(SprintStatus, :title => 'open', :id => 1)
    @sss2 = mock_model(SprintStatus, :title => 'closed', :id => 2)

    assigns[:sprint] = @sprint
    assigns[:product] = @p1
    assigns[:sprint_statuses] = [@sss1, @sss2]

  end

  it "should render new form to create a new sprint" do
    render "/sprints/new"
    
    response.should have_tag("form[action=?][method=post]", product_sprint_path(@p1, @sprint)) do
      with_tag("input#sprint_title[name=?]", "sprint[title]")
      with_tag("textarea#sprint_goal[name=?]", "sprint[goal]")
      with_tag("input#sprint_product_id[name=?]", "sprint[product_id]")

      with_tag('select#sprint_start_date_1i[name=?]', "sprint[start_date(1i)]")
      with_tag('select#sprint_start_date_2i[name=?]', "sprint[start_date(2i)]")
      with_tag('select#sprint_start_date_3i[name=?]', "sprint[start_date(3i)]")
      
      with_tag('select#sprint_end_date_1i[name=?]', "sprint[end_date(1i)]")
      with_tag('select#sprint_end_date_2i[name=?]', "sprint[end_date(2i)]")
      with_tag('select#sprint_end_date_3i[name=?]', "sprint[end_date(3i)]")

      with_tag("select#sprint_sprint_status_id[name=?]", "sprint[sprint_status_id]")
      
      with_tag('input#sprint_submit[value=?]', "Create New Sprint")

    end
  end
end


