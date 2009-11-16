class AlterUsersForAuthlogic < ActiveRecord::Migration
  def self.up
    # Rename the necessary columns
    rename_column :users, :salt, :password_salt
    
    # update columns
    change_column :users, :crypted_password, :string
    change_column :users, :password_salt, :string
    change_column :users, :login, :string
    
    # add thew new columns
    add_column :users, :persistence_token, :string
    add_column :users, :login_count, :integer, :null => false, :default => 0
    add_column :users, :failed_login_count, :integer, :null => false, :default => 0
    add_column :users, :last_request_at, :datetime
    add_column :users, :current_login_at, :datetime
    add_column :users, :last_login_at, :datetime
    add_column :users, :current_login_ip, :string
    add_column :users, :last_login_ip, :string
    
    # remove the unnecessary columns
    remove_column :users, :remember_token
    remove_column :users, :remember_token_expires_at
  end

  def self.down
    change_column :users, :login, :string
    change_column :users, :password_salt, :string
    change_column :users, :crypted_password, :string
    remove_column :users, :last_login_ip
    remove_column :users, :current_login_ip
    remove_column :users, :last_login_at
    remove_column :users, :current_login_at
    remove_column :users, :last_request_at
    remove_column :users, :failed_login_count
    remove_column :users, :login_count
    add_column :users, :remember_token_expires_at, :datetime
    add_column :users, :remember_token, :string,            :limit => 40
    remove_column :users, :persistence_token
    rename_column :users, :password_salt, :salt
  end
end
