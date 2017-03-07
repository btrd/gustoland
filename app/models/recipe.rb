class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients
  has_many :comments
  has_and_belongs_to_many :tags

  has_many :like_recipes
  has_many :like_users, through: :like_recipes, source: 'user'

  def likes
    like_users.count
  end
end
