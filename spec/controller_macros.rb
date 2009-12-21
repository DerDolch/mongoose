module ControllerMacros
  
  def login(opts={})
    activate_authlogic
    @user = User.create(valid_user_attributes)
    UserSession.create(@user)
  end
  
end