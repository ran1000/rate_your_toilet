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
    "Pariser Platz, 10117 Berlin",
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

  def baby_friendly?
    baby = attribute_status(self, "baby")
    clean = attribute_status(self, "clean")
    sink = attribute_status(self, "sink")
    soap = attribute_status(self, "soap")
    bin = attribute_status(self, "bin")
    true if baby &&
            sink &&
            bin &&
            soap &&
            clean
  end

  def period_friendly?
    spacious = attribute_status(self, "spacious")
    clean = attribute_status(self, "clean")
    sink = attribute_status(self, "sink")
    soap = attribute_status(self, "soap")
    bin = attribute_status(self, "bin")
    true if spacious &&
            sink &&
            bin &&
            soap &&
            clean
  end

  def accessible?
    spacious = attribute_status(self, "spacious")
    accessible = attribute_status(self, "accessible")
    true if spacious && accessible
  end

  def urinal?
    urinal = attribute_status(self, "urinal")
    true if urinal == true
  end

  def stall?
    clean = attribute_status(self, "clean")
    sink = attribute_status(self, "sink")
    paper = attribute_status(self, "paper")
    privacy = attribute_status(self, "privacy")
    true if clean &&
            sink &&
            paper &&
            privacy
  end

  def attribute_status(toilet, attribute)
    positives = toilet.reviews.where(reviews: { attribute => true }).count
    negatives = toilet.reviews.where(reviews: { attribute => false }).count
    return positives > negatives
  end
end

  # def baby_friendly?
  #   # baby-friendly attributes (:baby, :sink, :bin, :soap, :clean)
  #   baby_trues = self.reviews.where(reviews: { baby: true }).count
  #   baby_falses = self.reviews.where(reviews: { baby: false }).count

  #   sink_trues = self.reviews.where(reviews: { sink: true }).count
  #   sink_falses = self.reviews.where(reviews: { sink: false }).count

  #   bin_trues = self.reviews.where(reviews: { bin: true }).count
  #   bin_falses = self.reviews.where(reviews: { bin: false }).count

  #   soap_trues = self.reviews.where(reviews: { soap: true }).count
  #   soap_falses = self.reviews.where(reviews: { soap: false }).count

  #   clean_trues = self.reviews.where(reviews: { clean: true }).count
  #   clean_falses = self.reviews.where(reviews: { clean: false }).count

  #   true if baby_trues > baby_falses &&
  #           sink_trues > sink_falses &&
  #           bin_trues > bin_falses &&
  #           soap_trues > soap_falses &&
  #           clean_trues > clean_falses
