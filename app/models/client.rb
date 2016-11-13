class Client < ActiveRecord::Base
 has_many :users
 belongs_to :country
 validates_presence_of :name
 validates_presence_of :city
 validates_presence_of :address
 validates_presence_of :country_id
 accepts_nested_attributes_for :users

 geocoded_by :full_street_address
 after_validation :geocode


 def full_street_address
  "#{self.city}, #{self.state}, #{self.country.name}"
 end



end
