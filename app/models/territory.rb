class Territory < ActiveRecord::Base

  
  belongs_to  :zone
  has_many :addresses
  has_many :coordinates, :dependent => :delete_all
  has_many :territory_histories
  belongs_to :congregation
  has_many :territory_images
  before_destroy :ensure_no_children
  validates_presence_of :zone_id

  has_attached_file :image, styles: {thumb: "40x40#", terr: "500x500>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  def ensure_no_children
     unless self.addresses.count < 1
       self.errors.add_to_base "Can't destroy a Territory having addresses"
       raise ActiveRecord::Rollback

     end
   end
 










end
