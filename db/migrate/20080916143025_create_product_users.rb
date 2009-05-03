class CreateProductUsers < ActiveRecord::Migration
  def self.up
    create_table :product_users do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
    add_index :product_users, [:product_id, :user_id], :name => "product_users", :unique => true
  end

  def self.down
    remove_index :product_users, :name => :product_users
    drop_table :product_users
  end
end
