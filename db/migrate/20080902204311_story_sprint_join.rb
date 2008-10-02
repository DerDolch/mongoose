class StorySprintJoin < ActiveRecord::Migration
  def self.up
    create_table :sprints_stories, :id=>false do |t|
      t.integer :sprint_id 
      t.integer :story_id
    end
  end

  def self.down
    drop_table :sprints_stories
  end
end
