class Tag < ApplicationRecord
  has_and_belongs_to_many :recipes

  before_save :downcase_name

  def downcase_name
    self.name.downcase!
  end

  def image
    recipes.sort_by { |r| r.likes + r.books }.first.image
  end
end
