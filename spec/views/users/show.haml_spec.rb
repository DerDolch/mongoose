require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show" do
  include TasksHelper

  before(:each) do
    @u1 = mock_model(User, :updated_at => Time.now, :first_name => 'John', :last_name => 'Doe', :login => 'JohnDoe',
    :email =>'aaa@aaa.com', :created_at => Time.now, :user_status_id => 2, :password => '123456',
    :password_confirmation => '123456', :user_status => mock_model(UserStatus, :name => "Developer"))
    
    assigns[:user] = @u1
    
  end

  def do_render
    render "/users/show"
  end

  it "should be render view successfully" do
    do_render
    response.should be_success
  end
  
  it "should display the provided user info" do
    
    do_render
    
    response.should have_tag("h2", "User Profile: #{@u1.login.capitalize}")

    response.should have_tag('ul') do
       with_tag('li', "First Name:\n    #{@u1.first_name}")
       with_tag('li', "Last Name:\n    #{@u1.last_name}")
       with_tag('li', "Email Address:\n    #{@u1.email}")
    end
    
  end
  
  it "should limit allow un-privileged to only view the show page that matches their session id"
  
  
end