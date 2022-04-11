class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, :case_sensitive => false
  validates :password, presence: true, length: { minimum: 7 }
  validates :password_confirmation, presence: true, length: { minimum: 7 }

  def self.authenticate_with_credentials(email, password)
    @email = email.strip.downcase
    user = User.where("LOWER(email) = ?", @email).first

    puts User.where("LOWER(email) = ?", @email.downcase)

    return (user && user.authenticate(password) ? user : nil)
  end
end
