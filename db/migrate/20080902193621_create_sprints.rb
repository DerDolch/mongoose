class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.string      :title
      t.text        :goal
      t.date        :start_date
      t.date        :end_date
      t.integer     :product_id
      t.string      :status, :limit => 15
      t.timestamps
    end
    
    add_index :sprints, :product_id
    add_index :sprints, :status
  end

  def self.down
    remove_index :sprints, :status
    remove_index :sprints, :product_id
    drop_table :sprints
  end
end
