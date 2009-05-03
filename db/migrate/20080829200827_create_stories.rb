class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.integer     :product_id
      t.string      :title
      t.integer     :effort
      t.text        :description
      t.string      :status, :limit => 15
      t.timestamps
    end
    
    add_index :stories, :product_id
    add_index :stories, :status
  end

  def self.down
    remove_index :stories, :status
    remove_index :stories, :product_id
    drop_table :stories
  end
end
