class Product < ActiveRecord::Base
  
  # =============
  # = Constants =
  # =============
  STATUSES = ["Active", "On Hold", "Cancelled", "Done"].freeze
  
  # ================
  # = Associations =
  # ================
  has_many :stories, :dependent => :destroy, :order => "position"
  has_many :sprints
  has_many :users, :through => :product_users
  has_many :product_users, :dependent => :destroy
  
  # ===============
  # = Validations =
  # ===============
  validates_presence_of :name, :description, :identifier
  validates_length_of :name, :minimum => 5

  # =================
  # = Class Methods =
  # =================
  def self.has_access?(product_id, current_user)
    return true if product_id.nil? # FIXME: the "product_id" param is nil sometimes (like after login, after a bootstrap). Is it correct to say "has_access?" => false if the User tried to create a new Product?
    if current_user.user_status == UserStatus.find_by_name('Developer').id
      product_users = Product.find(product_id).users rescue [] # TODO: sure this is the place for these kinds of checks?
      return false if product_users.empty?
      product_users.any?{|u| u.id == current_user.id }
    else
      true
    end
  end

end

