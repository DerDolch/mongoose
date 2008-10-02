class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name, :limit => 100
      t.text :description
      t.string :identifier, :limit => 8
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
