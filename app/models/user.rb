class User < ApplicationRecord
  has_secure_password

  has_many :recipes
  has_many :comments
  has_many :notifications

  has_many :follower_subscriptions_follower, class_name: 'FollowerSubscription', foreign_key: 'follower_id'
  has_many :follower_subscriptions_followed, class_name: 'FollowerSubscription', foreign_key: 'followed_id'
  has_many :follows,    through: :follower_subscriptions_follower, source: :followed
  has_many :follow_by, through: :follower_subscriptions_followed, source: :follower

  has_many :like_recipes
  has_many :likes, through: :like_recipes, source: 'recipe'

  has_many :book_recipes
  has_many :books, through: :book_recipes, source: 'recipe'

  validates :nickname, :email, :name, presence: true
  validates :email, :nickname, uniqueness: true

  def as_json(options = {})
    json = super(options)
    if options[:current_user].present?
      user = User.find(options[:current_user])
      json['follow'] = user.follows.include?(self)
    else
      json['follow'] = false
    end
    json
  end
end
