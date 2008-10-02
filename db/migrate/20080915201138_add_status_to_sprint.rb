class AddStatusToSprint < ActiveRecord::Migration
  def self.up
    add_column :sprints, :sprint_status_id, :integer
  end

  def self.down
    remove_column :sprints, :sprint_status_id
  end
end
