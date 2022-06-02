class Toilet < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :reviews

  validates :name, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if:
  :will_save_change_to_address?


  def favorite?(user)
    favorites.find { |favorite| favorite.user_id == user.id }
  end
end
