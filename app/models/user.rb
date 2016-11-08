require 'digest/md5'
class User < ActiveRecord::Base
   @salt = "1914"
   belongs_to :client
   validates_uniqueness_of :username
   validates_presence_of :email
   validates_presence_of :fname
   validates_presence_of :username
   before_create :before_create_items




  def before_create_items

    self.password = User.encrypt(self.password)

  end





   def self.encrypt(pass)
   @encryptedPass = Digest::MD5.hexdigest(pass+@salt);
   return @encryptedPass
   end




   def self.authenticate(username, pass)


    @u = User.find_by(username: username)
    if @u.nil?
    Rails.logger.info "No Matching username was found"
    else
       @time = Time.now
       @u.lastlogin = @time
       @u.save
    end
  return nil if @u.nil?
  return @u if User.encrypt(pass) == @u.password


  @isGood = User.encrypt(pass) == @u.password
  nil
end



end
