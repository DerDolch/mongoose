class TeamsUsers < ActiveRecord::Migration
  def self.up
    create_table :teams_users, :id => false do |t|
      t.integer :team_id
      t.integer :user_id
    end
    add_index :teams_users, :team_id
    add_index :teams_users, :user_id
  end

  def self.down
    remove_index :teams_users, :user_id
    remove_index :teams_users, :team_id
    drop_table :teams_users
  end
end
