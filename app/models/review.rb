class Review < ApplicationRecord
  belongs_to :toilet
  belongs_to :user

  validates :rating, presence: true, format: { with: /[1-5]/ }
end
