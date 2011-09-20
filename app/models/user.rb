# User model
# 
# Table name: users
#
# id                 :integer         not null, primary key
# nick               :string(16)      index, unique
# name               :string(255)
# email              :string(50)      index, unique
# encrypted_password :string(255)
# salt               :string(255)
#
require 'digest'
class User < ActiveRecord::Base
  # Attributes
  attr_accessor :password
  attr_accessible :nick, :name, :email, :password, :password_confirmation
  
  # Constants
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # Validations
  validates :nick,  :presence   => true,
                    :length     => { :within => 3..16 },
                    :format     => { :with => /^[a-zA-Z0-9_-]+$/ },
                    :uniqueness => { :case_sensitive => false }
  validates :name,  :presence => true
  validates :email, :presence   => true,
                    :length     => { :maximum => 50  },
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 },
                       :format       => { :with => /^[a-zA-Z0-9_-]+$/ },
                       :on           => :create
               
  # Callbacks        
  before_save :encrypt_password, :unless => Proc.new { |user| user.password.nil? }
  
  # ------------------------------------------------------------------------------------------------------
  # Class methods
  # ------------------------------------------------------------------------------------------------------
  
  # authenticate
  # Return the user if the nick or email and submitted password mathces else return nil
  # @param identificator => string (nick or email)
  # @param submitted_password => string
  # @return instance user or nil
  #
  def self.authenticate(identificator, submitted_password)
    user = find(:first, :conditions => ["nick = ? or email = ?", identificator, identificator])
    user && user.has_password?(submitted_password) ? user : nil
  end
  
  # authenticate_with_salt
  # Return the user if the id and the cookie_salt matches else return nil
  # @param id => integer
  # @param cookie_salt => string
  # @return instance user or nil
  #
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    user && user.salt == cookie_salt ? user : nil
  end
  
  # ------------------------------------------------------------------------------------------------------
  # Instance methods
  # ------------------------------------------------------------------------------------------------------
  
  # has_password?
  # Return true if the user's password matches the submitted password.
  # @param submitted_password => string
  # @return boolean
  #
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  private
    
    # encrypt_password
    # set the password encrypted and make salt if is a new record
    # @return string (encrypted password)
    #
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    # encrypt
    # ecnrypt a string password with user salt and return it
    # @param string => string
    # @return string (encrypted password)
    #
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    # make_salt
    # make the salt user with the date of today and user's password
    # @return string (user's new salt)
    #
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    # secure_hash
    # make secure hash for a string parsing with Digest::SHA2 hexdigest
    # @param string => string
    # @return string (secure hash)
    #
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
