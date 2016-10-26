class Country < ActiveRecord::Base

  has_many :employee_applications
  has_many :zones
  has_many :item_destinations
  has_attached_file :flag, styles: {thumb: "40x40", big: "100x100#" }
  validates_attachment_content_type :flag, content_type: /\Aimage\/.*\Z/


end
