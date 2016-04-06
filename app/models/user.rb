class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

# Virtual attribute for authenticating by either username or email
# This is in addition to a real persisted field like 'username'
  attr_accessor :login
  validates :username, :presence => true, :uniqueness => {:case_sensitive => false}
  validate :validate_username


  # def self.find_for_database_authentication(warden_conditions)
  #   byebug
  # end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      user = where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end


  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
end
