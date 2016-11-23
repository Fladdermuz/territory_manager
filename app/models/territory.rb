class Territory < ActiveRecord::Base


  belongs_to  :zone
  has_many :addresses
  has_many :coordinates, :dependent => :delete_all
  has_many :territory_histories
  belongs_to :client
  has_many :territory_images
  before_destroy :ensure_no_children
  validates_presence_of :zone_id


  def self.no_cords(client_id)

  @territories_without = Array.new
  Territory.where(client_id: client_id).each do |t|
   if t.coordinates.count < 1
    @territories_without.push(t.id)
   end
  end

   return  @territories_without

  end

  def get_checked_out_by

   @user = User.find_by(id: self.checked_out_by)
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
