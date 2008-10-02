class AddProductStatusIdToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :product_status_id, :integer
  end

  def self.down
    remove_column :products, :product_status_id
  end
end
