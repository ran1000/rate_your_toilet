class Toilet < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :reviews

  validates :name, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def favorite?(user)
    favorites.find { |favorite| favorite.user_id == user.id }
  end
  RESTAURANTS_ADDRESSES = [
    "Lindenstraße 9-14, 10969 Berlin",
    "Leipziger Pl. 12, 10117 Berlin",
    "Askanischer Pl. 2, 10963 Berlin",
    "Charlottenstraße 16, 10117 Berlin",
    "Axel-Springer-Straße 65, 10969 Berlin",
    "Kochstraße 16, 10969 Berlin", "Markgrafenstraße 56, 10117 Berlin"
  ].freeze

  TOILETPHOTOS = [
    "Basic Toilet",
    "Comfy Toilet",
    "Regular Toilet"
  ].freeze
end
