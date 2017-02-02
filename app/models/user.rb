class User < ApplicationRecord
  has_secure_password
  validates :nickname, :email, :name, presence: true
  validates :email, :nickname, uniqueness: true
end
