class Sprint < ActiveRecord::Base
  
  validates_presence_of :title, :goal, :start_date, :end_date
  belongs_to :product
  belongs_to :sprint_status
  
  validate :check_dates
  
  has_and_belongs_to_many :stories
  
  named_scope :active_sprints, :conditions => { :sprint_status_id => 0..1 }
  
  def self.find_current_sprint_from_id(product_id)
    find(:first, :conditions => ["product_id = ?", product_id])
  end

  def self.find_sprints_from_id(product_id)
    find(:first, :conditions => ["product_id = ?", product_id])
  end

  def check_dates
    errors.add(:start_date, "must be less than or equal to end date") if start_date > end_date
  end

  # START

  def self.find_sprints_from_id_and_status(product_id, status_id)
    find(:all, :conditions => ["product_id = ? AND sprint_status_id = ?", product_id, status_id ])
  end

end
