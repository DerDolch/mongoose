module ControllerMacros
  
  def login_as_mock_user(opts={})
    @user = mock_model(User, opts)
    session[:user_id] = @user.id
    User.stub!(:find_by_id).with(@user.id).and_return(@user)
    User.current_user = @user
  end
  
end