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
  RESTAURANTS_ADDRESSES = [
    "Rudi-Dutschke-Straße 17, 10969 Berlin",
    "Rudi-Dutschke-Strasse 26, 10969 Berlin",
    "Friedrichstraße 207 208, 10969 Berlin",
    "Charlottenstraße 16, 10117 Berlin",
    "Rudi-Dutschke-Straße 25, 10969 Berlin",
    "Kochstraße 16, 10969 Berlin", "Markgrafenstraße 56, 10117 Berlin"
  ].freeze

  TOILETPHOTOS = [
    "Basic Toilet",
    "Comfy Toilet",
    "Regular Toilet"
  ].freeze
end
