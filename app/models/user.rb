require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password

   attr_accessible :username, :email, :password, :password_confirmation,:role_ids, :user_id,:username, :firstname, :lastname,:plan_id,:plan_type,:companyname, :hear_aboutus,:admin_user_id,:photo,:time_zone,:fullname, :plan_name
   has_attached_file :photo,:styles =>{:small => "150x150>"}
   validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png"]
   has_and_belongs_to_many :roles
   has_one :plan


   has_many :settings 
   belongs_to :nominee 


   has_one :settings  
   has_one :prop
   has_one :vote_setting
   has_one :setting

  #model based validation
   # validates :firstname, :presence => true, 
   #                :length => { :maximum => 50 }
   email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email,:uniqueness => { :case_sensitive => false }

    validates :password,  :confirmation => true,:on => :create

   before_save :encrypt_password
   before_create { generate_token(:auth_token) }

    
    #method for password reset
	def send_password_reset
	  generate_token(:password_reset_token)
	  self.password_reset_sent_at = Time.zone.now
	  save!
	  UserMailer.password_reset(self).deliver
	end
    #method for generating authentication token. 
	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	end

	def has_password?(submitted_password)
	  encrypted_password == encrypt(submitted_password)
	end

	class << self
	def authenticate(email, submitted_password)
	user = find_by_email(email)
	(user && user.has_password?(submitted_password)) ? user :nil

	end

	def authenticate_with_salt(id,cookie_salt)
	  user = find_by_id(id)
	  (user && user.salt == cookie_salt) ? user :nil
	end 
	end
	def role?(role)
	  return !!self.roles.find_by_name(role.to_s)
	end
			
  private
	def encrypt_password
	self.salt = make_salt if new_record?
	self.encrypted_password = encrypt(password)
	end

	def encrypt(string)
	secure_hash("#{salt}--#{string}")
	end

	def make_salt
	secure_hash("#{Time.now.utc}--#{password}")
	end

	def secure_hash(string)
	Digest::SHA2.hexdigest(string)
	end

	
end
