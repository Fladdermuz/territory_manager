class Territory < ActiveRecord::Base

  belongs_to :user
  belongs_to  :zone
  has_many :addresses
  has_many :coordinates, :dependent => :delete_all
  has_many :territory_histories
  belongs_to :client
  before_update :create_key
  has_many :territory_images
  before_destroy :ensure_no_children
  validates_presence_of :zone_id
  validates_presence_of :center_coordinate
  validates_presence_of :user_id, if: Proc.new { |r| !r.is_checked_in? }
  before_create :check_map_layer


  def check_map_layer
    if self.map_layer_id.blank?
       self.map_layer_id = 1
    end
  end


 def create_key

  @checked = self.is_checked_in_was
  @now_checked = self.is_checked_in

  if @checked && !@now_checked
    self.view_key = Territory.encrypt(self.user_id.to_s+self.checkout_date.to_s)
  end


 end







 def self.encrypt(key)
   @encrypted  = Digest::MD5.hexdigest(key);
   return @encrypted
 end


  def self.no_cords(client_id)

  @territories_without = Array.new
  Territory.where(client_id: client_id).each do |t|
   if t.coordinates.count < 1
    @territories_without.push(t.id)
   end
  end

   return  @territories_without

  end

  def get_user_id

   @user = User.find_by(id: self.user_id)
   if @user.nil?
     ""
   else
     "#{@user.full_name}"
   end


  end


  def ensure_no_children
     unless self.addresses.count < 1
       self.errors.add_to_base "Can't destroy a Territory having addresses"
       raise ActiveRecord::Rollback

     end
   end











end
