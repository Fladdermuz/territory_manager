class Client < ActiveRecord::Base
 has_many :users
 belongs_to :country
 before_update :check_update
 validates_presence_of :name

 accepts_nested_attributes_for :users

 def check_update

   @count = Client.all.count
   @country_was = self.country_id_was

   if @country_was != self.country_id
    self.coordinate = self.country.latitude.to_s + "," + self.country.longitude.to_s
   end

   if self.coordinate.to_s == "38.802859, -96.208728" || self.coordinate.blank?
      self.errors.add(:base, I18n.t("must_have_coord"))
      return FALSE unless @count < 1
   end




 end


end
