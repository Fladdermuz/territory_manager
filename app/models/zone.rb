class Zone < ActiveRecord::Base

  before_destroy :ensure_no_children
  has_many :territories
  belongs_to :map_layer
  has_many :coordinates, dependent: :destroy
  belongs_to :client

  validates_presence_of :center_coordinate
  validates_presence_of :client_id
  validates_presence_of :zone_no
  before_create :check_map_layer



  def check_map_layer
    if self.map_layer_id.blank?
       self.map_layer_id = 1
    end
  end

  def self.no_cords(client_id)

  @zones_without = Array.new
  Zone.where(client_id: client_id).each do |z|
   if z.coordinates.count < 1
    @zones_without.push(z.id)
   end
  end

 return  @zones_without

  end




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
