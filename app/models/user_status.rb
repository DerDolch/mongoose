class UserStatus < ActiveRecord::Base
  
  has_many :users

  def name_with_initial
    "#{first_name.first}. #{last_name}"
  end  
end
