require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/index" do
  include TasksHelper

  before(:each) do
    @u1 = mock_model(User, :updated_at => Time.now, :first_name => 'John', :last_name => 'Doe', :login => 'JohnDoe', :email =>'aaa@aaa.com', :created_at => Time.now)
    @u2 = mock_model(User, :updated_at => Time.now, :first_name => 'Jane', :last_name => 'Doe', :login => 'JohnDoe', :email =>'aaa@aaa.com', :created_at => Time.now)
    assigns[:users] = [@u1,@u2]
  end

  def do_render
    render "/users/index"
  end

  it "should be render view successfully" do
    do_render
    response.should be_success
  end

  it "should render a title" do
    have_tag('h2', "Master User List")
  end
  
  it "should display a list of all users" do
    do_render
    response.should have_tag('table') do
       with_tag('td', @u1.login)
       with_tag('td', @u1.first_name)
       with_tag('td', @u1.last_name)
    end
  end
  
  it "should restrict access to anuthorized users withitout super admin status"
  
end