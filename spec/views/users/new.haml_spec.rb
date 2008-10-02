require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/new" do
  include TasksHelper

  before(:each) do
    @user = User.new
    assigns[:user] = @user 
  end

  def do_render
    render "/users/new"
  end

  it "should be render view successfully" do
    do_render
    response.should be_success
  end
  
  it "should render a form to sign up" do
    do_render
    response.should have_tag("fieldset form[action=?][method=post]", users_path) do
      with_tag("input#user_login[name=?]", "user[login]")
      with_tag("input#user_first_name[name=?]", "user[first_name]")
      with_tag("input#user_last_name[name=?]", "user[last_name]")
      with_tag("input#user_email[name=?]", "user[email]")
      with_tag("input#user_password[name=?]", "user[password]")
      with_tag("input#user_password_confirmation[name=?]", "user[password_confirmation]")
    end
    
  end
  
end