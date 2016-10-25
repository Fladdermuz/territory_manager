class Zone < ActiveRecord::Base

  before_destroy :ensure_no_children
  has_many :territories
 
    before_destroy :ensure_no_children


   def ensure_no_children

     if self.territories.count > 0
       return FALSE
     end


   end

  




end
