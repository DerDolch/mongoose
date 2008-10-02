class AddNamesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string, :limit => 200, :default => '', :null => true
    add_column :users, :last_name, :string, :limit => 200, :default => '', :null => true
    add_column :users, :user_status_id, :integer
    remove_column :users, :name
  end

  def self.down
    remove_column :users, :user_status_id
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
