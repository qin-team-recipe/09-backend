class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :user_sites, dependent: :destroy
  has_many :user_ingredients, dependent: :destroy
  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  attribute :avatar, :string, default: '/images/default-avatar.jpg'

  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

    def follow(other_user)
      following << other_user
    end

    def unfollow(other_user)
      following_relationships.find_by(followed_id: other_user.id).destroy
    end

    def following?(other_user)
      following.include?(other_user)
    end
end
