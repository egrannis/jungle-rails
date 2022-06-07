class User < ApplicationRecord

  has_secure_password # suggested approach from compass
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.authenticate_with_credentials(email, password)
    lower_email = email.downcase
    user = User.find_by(email: lower_email)
    user && user.authenticate(password)
  end
end

#Passwords should be stored as hashed strings instead of plain text so that no one can know what they are. 
#During registration, users must supply a password as well as password_confirmation. 
# That said, you won't need to store either of these fields in the database since they are used to ensure that they are always the same and the password is not mistyped. 
# Instead you will store the hashed password into a password_digest field. Refer to the tips section below for help with this.