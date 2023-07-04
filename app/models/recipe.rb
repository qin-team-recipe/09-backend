class Recipe < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :recipe_images, dependent: :destroy
  has_many :recipe_sites, dependent: :destroy
  has_many :user_ingredients, dependent: :destroy

  validates :name, presence: true
end
