require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password


   attr_accessible :username, :email, :password, :password_confirmation,:role_ids, :user_id,:username, :firstname, :lastname,:plan_id,:plan_type,:companyname, :hear_aboutus,:admin_user_id,:photo,:time_zone,:fullname, 
                   :plan_name,:department,:is_prop,:is_prop_reminder,:is_vote_reminder,:agree,:department
   has_attached_file :photo,:styles =>{:micro => "30x30#", :small => "150x150>"},
  :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml",
  :path => "public/attachments/user/:id/:style/:basename.:extension",
  :convert_options => {
                          :thumb => "-background '#F7F4F4' -compose Copy -gravity center -extent 230x200"
                      }
   validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png"]
   has_and_belongs_to_many :roles

   has_one :plan

   has_one :setting 
   belongs_to :nominee 
   has_many :prop_counts
   has_many :results
   has_many :prop_results
   has_many :engage_users
   has_many :vote_counts
   has_many :vote_other_counts
   has_one :settings  
   has_one :prop
   has_one :vote_setting
   has_one :setting
   belongs_to :trial_day
 
   belongs_to :admin_user ,:class_name => 'User' 


  #model based validation
   # validates :firstname, :presence => true, 
   #                :length => { :maximum => 50 }
   email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email,:uniqueness => { :case_sensitive => false },:presence => { :message => " cannot be blank" }

    validates :password,  :confirmation => true,:on => :create

   before_save :encrypt_password
   before_create { generate_token(:auth_token) }

  
   
    acts_as_liker
    
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

   #Method for trial days for admin
  def self.admin_user_plan_expiry(user)     
      @trial_days = TrialDay.first     
      @admin_user_plan_expiry = (user.created_at + @trial_days.days.days)
      @current_date = (Time.zone.now)
      @remaining_days = (@admin_user_plan_expiry - @current_date).to_i / 1.day       
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




def self.to_csv
      CSV.generate do |csv|
        csv << column_names
        all.each do |user|
          csv << user.attributes.values_at(*column_names)
        end
      end
end








def self.import(file, current_user)  

  current_user = current_user.id #admin current id

  CSV.foreach(file.path, skip_blanks: true, headers: true) do |row|
    @random_password = (0..6).map{ ('a'..'z').to_a[rand(26)] }.join
    add = row.to_hash

    @check_user = User.find_by_email(add['email'])
    if @check_user.present?
      @check_user.update_attributes(:firstname => add['firstname'],:lastname => add['lastname'],:department => add['department'], :fullname => add['firstname'] + ' ' + add['lastname'])
    else
      @user = User.create(:firstname => add['firstname'],:lastname => add['lastname'],:email =>add['email'],:department => add['department'],:role_ids => 3 ,:password =>@random_password ,:password_confirmation =>@random_password,:admin_user_id => current_user, :fullname => add['firstname'] + ' ' + add['lastname'])
      if @user.save
        UserMailer.uploaduser_verifymail(@user,@random_password).deliver
      end
    end
#    if @user.save
#      @user.update_column(:fullname,"#{[:firstname]} #{[:lastname]} ")
#      UserMailer.delay(run_at: 1.minutes.from_now).uploaduser_verifymail(@user,@random_password)
#    end
  end
end










      
  private
  
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password) unless password.nil? 
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
