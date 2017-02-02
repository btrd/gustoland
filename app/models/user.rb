class User < ApplicationRecord
  has_secure_password
  validates :nickname, :email, :name, :password, presence: true
  validates :email, :nickname, uniqueness: true
  validates :password, length: { minimum: 8 }
end
