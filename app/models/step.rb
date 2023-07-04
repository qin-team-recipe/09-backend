class Step < ApplicationRecord
  belongs_to :recipe

  validates :description, presence: true
  validates :order, presence: true
end
