class Zone < ActiveRecord::Base

  before_destroy :ensure_no_children
  has_many :territories
  belongs_to :map_layer
  has_many :coordinates, dependent: :destroy
  belongs_to :client

  validates_presence_of :center_coordinate
  validates_presence_of :client_id
  validates_presence_of :zone_no

  has_attached_file :image, styles: {thumb: "40x40#", zone: "200x200>" }, :use_timestamp => false, default_url: "/images/clients/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def get_recipient_count
   @count = 0
   self.territories.each do |t|
      t.addresses.each do |a|
       @count += a.users.count
      end
   end

   @count

  end

 def get_address_count
  @count = 0
  self.territories.each do |t|

   @count += t.addresses.count

  end

  @count

 end


   def ensure_no_children

     if self.territories.count > 0
       return FALSE
     end

   end


end
