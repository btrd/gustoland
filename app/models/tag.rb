class Tag < ApplicationRecord
  has_and_belongs_to_many :recipes

  before_save :downcase_name

  def downcase_name
    self.name.downcase!
  end

  def image
    tag = recipes.sort_by { |r| r.popularity }.first
    tag.image if tag.present?
  end
end
