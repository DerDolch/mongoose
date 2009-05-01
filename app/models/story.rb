class Story < ActiveRecord::Base
  
  acts_as_list :scope => :product

  # ================
  # = Associations =
  # ================
  belongs_to :product
  has_many :tasks, :dependent => :destroy
  has_and_belongs_to_many :sprints
  
  # ===============
  # = Validations =
  # ===============
  validates_presence_of :title, :description
  validates_length_of :title, :within => 5..255
  
  # ================
  # = Named Scopes =
  # ================
  named_scope :unassigned, {:conditions => '(sprint_id = 0 OR sprint_id IS NULL)'}
  
  
  def self.find_current_sprint_stories(sprint, product)
    find(:all, :conditions => ['sprint_id = ? AND product_id = ?', sprint, product ], :order => :position)
  end

  def self.find_story_backlog_from_id(product)
    find(:all, :conditions => ['(sprint_id = ? OR sprint_id IS NULL) AND product_id = ?', 0, product ], :order => :position)
  end

  def self.find_story_list_from_sprint_id(sprint)
    find(:all, :conditions => ['sprint_id = ?', sprint ], :order => :position)
  end
 
end