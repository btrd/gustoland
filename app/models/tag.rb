class Tag < ApplicationRecord
  has_and_belongs_to_many :recipes

  def image
    recipes.sort_by { |r| r.likes + r.books }.first.image
  end
end
