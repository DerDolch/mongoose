class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.string :name
      t.date :start_at
      t.date :release_at
      t.integer :product_id

      t.timestamps
    end
    add_index :releases, :product_id
  end

  def self.down
    remove_index :releases, :product_id
    drop_table :releases
  end
end
