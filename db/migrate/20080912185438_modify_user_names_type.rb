class ModifyUserNamesType < ActiveRecord::Migration
  def self.up
    change_column :users, :first_name, :string
    change_column :users, :last_name, :string
  end

  def self.down
    change_column :users, :first_name, :integer
    change_column :users, :last_name, :integer
  end
end
