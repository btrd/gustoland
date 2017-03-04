class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients
  has_many :comments
  has_and_belongs_to_many :tags
end
