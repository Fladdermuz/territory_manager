class Client < ActiveRecord::Base
 has_many :users
 belongs_to :country
 before_create :check_create
 validates_presence_of :name

 accepts_nested_attributes_for :users

 def check_create

   @count = Client.all.count

   if self.coordinate.to_s == "38.802859, -96.208728" || self.coordinate.blank?
      self.errors.add(:base, I18n.t("must_have_coord"))
      return FALSE unless @count < 1
   end


 end


end
