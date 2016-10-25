class Address < ActiveRecord::Base

belongs_to :territory
has_many :householders, :dependent => :delete_all
belongs_to :congregation
accepts_nested_attributes_for :householders

validates_uniqueness_of :house_no, :scope => [:street,:city,:apt_no,:territory_id,:congregation_id]


  def fulladdy

   @txt = ''
   if !self.neighborhood.nil?
     @txt += self.neighborhood
   end

   if !self.house_no.nil?
     @txt += ' ' + self.house_no
   end

   if !self.street.nil?
     @txt += ' ' + self.street
   end


   if !self.apt_no.nil?
     @txt += ' ' + self.apt_no
   end


   if !self.city.nil?
     @txt += ' ' + self.city
   end




   return @txt

  end

  
end
