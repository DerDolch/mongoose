class CreateProductStatuses < ActiveRecord::Migration
  def self.up
    create_table :product_statuses do |t|
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :product_statuses
  end
end
