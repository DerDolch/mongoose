class AddSprintStatuses < ActiveRecord::Migration
  def self.up
    create_table :sprint_statuses do |t|
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :sprint_statuses
  end
end
