class AddSprintIdToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :sprint_id, :integer
    add_index :stories, :sprint_id
  end

  def self.down
    remove_index :stories, :sprint_id
    remove_column :stories, :sprint_id
  end
end
