require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/edit" do
  include TasksHelper

  before(:each) do
    @u1 = mock_model(User, valid_user_attributes)

    @cuser = mock_model(User, :first_name => "John", :last_name => "Doe", :login => "johndoe", :status => 'Active')
    
    template.stub!(:current_user).and_return(@cuser)
    assigns[:current_user] = @cuser
    assigns[:user] = @u1
    assigns[:user_statuses] = @usess
  end

  def do_render
    render "/users/edit"
  end

  it "should be render view successfully" do
    do_render
    response.should be_success
  end
  
  it "should render an edit form" do
    do_render
    
    response.should have_tag("form[action=?][method=post]", user_path(@u1)) do
      with_tag('input#user_login[name=?]', "user[login]")
      with_tag('input#user_email[name=?]', "user[email]")
      with_tag('input#user_first_name[name=?]', "user[first_name]")
      with_tag('input#user_last_name[name=?]', "user[last_name]")
      with_tag("select#user_status[name=?]", "user[status]")
      with_tag('input#user_password[name=?]', "user[password]")
      with_tag('input#user_password_confirmation[name=?]', "user[password_confirmation]")

    end
  end
  
end