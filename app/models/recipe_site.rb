class RecipeSite < ApplicationRecord
  belongs_to :recipe

  validates :url, presence: true
end
