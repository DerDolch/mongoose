class Release < ActiveRecord::Base

  # ================
  # = Associations =
  # ================
  has_many :strories
  belongs_to :product

  # ===============
  # = Validations =
  # ===============
  validates_presence_of :name

end
