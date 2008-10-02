class ModiftySprints < ActiveRecord::Migration
  def self.up
    change_column :sprints, :start_date, :date
    change_column :sprints, :end_date, :date
  end

  def self.down
    change_column :sprints, :start_date, :datetime
    change_column :sprints, :end_date, :datetime
  end
end
