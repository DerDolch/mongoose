class Task < ActiveRecord::Base
  
  # =============
  # = Constants =
  # =============
  STATUSES = ["Not Started", "Impeded", "Haulted", "In Progress", "Completed"].freeze
  
  # ================
  # = Associations =
  # ================
  belongs_to :story
  
  # ===============
  # = Validations =
  # ===============
  validates_presence_of :title, :description, :status
  validates_length_of :title, :minimum => 5
  
end
