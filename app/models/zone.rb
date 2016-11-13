class Zone < ActiveRecord::Base

  before_destroy :ensure_no_children
  has_many :territories
  belongs_to :map_layer
  has_many :coordinates, dependent: :destroy
  belongs_to :client

  validates_presence_of :center_coordinate
  validates_presence_of :client_id
  validates_presence_of :zone_no
  validates_presence_of :map_layer_id

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
