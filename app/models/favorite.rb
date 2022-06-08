class Favorite < ApplicationRecord
  belongs_to :toilet
  belongs_to :user

  validates :user_id, uniqueness: { scope: :toilet_id }
end
