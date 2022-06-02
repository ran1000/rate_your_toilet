class Review < ApplicationRecord
  belongs_to :toilet
  belongs_to :user
  has_many_attached :photos

  validates :rating, presence: true, format: { with: /[1-5]/ }
end
