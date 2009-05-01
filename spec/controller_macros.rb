module ControllerMacros
  
  def login_as_mock_user(opts={})
    @user = mock_model(User, opts)
    @user.stub!(:user_status).and_return(mock_model(UserStatus, :id => 3, :name => 'Super User'))
    session[:user_id] = @user.id
    User.stub!(:find_by_id).with(@user.id).and_return(@user)
    User.current_user = @user
  end
  
end