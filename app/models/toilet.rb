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
    "Besselstraße, 10969 Berlin",
    "Scheidemannstraße 1, 10557 Berlin",
    "Georgenstraße 14, 10117 Berlin",
    "Leipziger Str. 111, 10117 Berlin",
    "Alte Jakobstraße 111, 10969 Berlin",
    "Linkstraße 10, 10785 Berlin",
    "Am Lustgarten 1, 10178 Berlin",
    "Rungestraße 31, 10179 Berlin",
    "Lindenstraße 14, 10969 Berlin",
    "Pariser Platz, 10117 Berlin",
    "Askanischer Pl. 2, 10963 Berlin",
    "Charlottenstraße 49, 10117 Berlin",
    "Hausvogteipl. 11, 10117 Berlin",
    "Lausitzer Pl. 5, 10997 Berlin",
    "Planufer 96, 10967 Berlin",
    "Weinbergsweg 8, 10119 Berlin",
    "Erich-Steinfurth-Straße 11, 10243 Berlin",
    "Friedenstraße, 10249 Berlin",
    "Schlesische Str. 42, 10997 Berlin",
    "Hasenheide park, 12049 Berlin",
    "Straße 645, Am Tempelhofer Feld, 12049 Berlin",
    "Schillerpromenade 5, 12049 Berlin",
    "Mainzer Str., 12053 Berlin",
    "Elbestraße 1 Ecke, Sonnenallee, 12045 Berlin",
    "Sonnenallee 4, 10967 Berlin",
    "Leipziger Pl. 12, 10117 Berlin",
    "Georgenstraße 14/17, 10117 Berlin",
    "Am Zwirngraben, 10178 Berlin",
    "Grunerstraße 20, 10179 Berlin"
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

  def easy?
    clean = attribute_status(self, "clean")
    spacious = attribute_status(self, "spacious")
    paper = attribute_status(self, "paper")
    privacy = attribute_status(self, "privacy")
    true if clean &&
            spacious &&
            paper &&
            privacy
  end

  def changing_room?
    clean = attribute_status(self, "clean")
    spacious = attribute_status(self, "spacious")
    hanger = attribute_status(self, "hanger")
    privacy = attribute_status(self, "privacy")
    true if clean &&
            spacious &&
            hanger &&
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
