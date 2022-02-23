class User < ApplicationRecord
  validates :username, presence: true
  validates :full_name, presence: true
  validates :email_address, presence: true

  has_secure_password
end
