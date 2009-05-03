class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string  :name, :limit => 100
      t.text    :description
      t.string  :identifier, :limit => 8
      t.string  :status, :limit => 15
      t.timestamps
    end
    add_index :products, :status
  end

  def self.down
    remove_index :products, :status
    drop_table :products
  end
end
