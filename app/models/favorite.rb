class Favorite < ApplicationRecord
  belongs_to :toilet
  belongs_to :user

  validates :user_id, uniqueness: { scope: :toilet_id, message: "a toilet can be favorized only once" }

end
