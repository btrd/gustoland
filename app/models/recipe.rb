class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients
  has_many :comments
  has_and_belongs_to_many :tags

  has_many :like_recipes
  has_many :like_users, through: :like_recipes, source: 'user'

  has_many :book_recipes
  has_many :book_users, through: :book_recipes, source: 'user'

  def likes
    like_users.count
  end

  def books
    book_users.count
  end

  def count_comment
    comments.count
  end

  def popularity
    likes + books + count_comment
  end

  def as_json(options = {})
    json = super(options)
    if options[:current_user].present?
      user = User.find(options[:current_user])
      json['like'] = user.likes.include?(self)
      json['book'] = user.books.include?(self)
    else
      json['like'] = false
      json['book'] = false
    end
    json
  end
end
