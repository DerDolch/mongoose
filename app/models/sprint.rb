class Sprint < ActiveRecord::Base
  
  # ================
  # = Associations =
  # ================
  belongs_to :product
  belongs_to :sprint_status
  has_and_belongs_to_many :stories
  
  # ===============
  # = Validations =
  # ===============
  validates_presence_of :title, :goal, :start_date, :end_date  
  validate :check_dates
  
  def check_dates
    errors.add(:start_date, "must be less than or equal to end date") if start_date > end_date
  end
  
  # ================
  # = Named Scopes =
  # ================
  named_scope :active, :conditions => { :sprint_status_id => 1 }
  named_scope :completed, :conditions => { :sprint_status_id => 2 }
  
end
