require 'digest/md5'
class User < ActiveRecord::Base
   @salt = "1914"
   belongs_to :client
   has_many :warning_messages
   validates_uniqueness_of :username
   validates_presence_of :username
   validates_presence_of :email
   validates_presence_of :fname
   validates_presence_of :client_id
   validates_presence_of :username
   before_create :before_create_items
   before_update :change_pass


  def change_pass

      if self.must_change_pass? && self.password != self.password_was
         self.must_change_pass = FALSE
      end


  end

  def before_create_items

    if self.username != 'admin'
     self.password = User.encrypt(self.password)
    end

  end


   def full_name

   "#{self.fname} #{self.lname}"

   end





   def self.encrypt(pass)
    @encryptedPass = Digest::MD5.hexdigest(pass+@salt);
    return @encryptedPass
   end




   def self.authenticate(username, pass)

    @u = User.find_by(username: username)
      if @u.nil?
       Rails.logger.info "No Matching username was found"
      end

       return nil if @u.nil?
       return @u if User.encrypt(pass) == @u.password || User.encrypt(@u.username) == User.encrypt(@u.password)
       @isGood = User.encrypt(pass) == @u.password
       nil
   end



end
