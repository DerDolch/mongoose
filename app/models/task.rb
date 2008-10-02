class Task < ActiveRecord::Base
  
  belongs_to :story
  belongs_to :task_status
  
  validates_presence_of :title, :description, :task_status_id
  validates_length_of :title, :minimum => 5
  
end
