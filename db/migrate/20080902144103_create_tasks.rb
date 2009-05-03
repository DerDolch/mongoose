class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer     :story_id
      t.string      :title
      t.text        :description
      t.integer     :hours
      t.integer     :user_id
      t.string      :status, :limit => 15
      t.timestamps
    end
    add_index :tasks, :story_id
    add_index :tasks, :user_id
    add_index :tasks, :status
  end

  def self.down
    remove_index :tasks, :status
    remove_index :tasks, :user_id
    remove_index :tasks, :story_id
    drop_table :tasks
  end
end
