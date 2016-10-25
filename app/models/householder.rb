class Householder < ActiveRecord::Base

  belongs_to :address


  def fullname

    if !self.lname.nil?  && !self.fname.nil?
     self.fname + ' ' + self.lname
    end

  end

end
