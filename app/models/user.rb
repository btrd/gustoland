class User < ApplicationRecord
  has_secure_password

  has_many :recipes

  validates :nickname, :email, :name, presence: true
  validates :email, :nickname, uniqueness: true
end
