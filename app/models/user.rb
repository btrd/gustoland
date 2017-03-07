class User < ApplicationRecord
  has_secure_password

  has_many :recipes
  has_many :comments

  has_many :follower_subscriptions_follower, class_name: 'FollowerSubscription', foreign_key: 'follower_id'
  has_many :follower_subscriptions_followed, class_name: 'FollowerSubscription', foreign_key: 'followed_id'
  has_many :follow,    through: :follower_subscriptions_follower, source: :followed
  has_many :follow_by, through: :follower_subscriptions_followed, source: :follower

  validates :nickname, :email, :name, presence: true
  validates :email, :nickname, uniqueness: true
end
