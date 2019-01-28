class Recipe < ApplicationRecord
  # This is the ISO 8601 standardised time format
  TIME_FORMAT_REGEX = /P(\d{1,2}D)?(T\d{1,2}(H|M))?(\d{1,2}(H|M))?/
  CONNECTIVES = %w(and with of au a la)
  PUNCTUATION = %w(' " , - )

  has_many :ingredient_sets, dependent: :destroy
  has_many :method_steps, dependent: :destroy
  has_many :tags, as: :taggable, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { maximum: 50 }
  validates :total_time, format: { :with => TIME_FORMAT_REGEX,
    :message => "total_time must be in valid ISO 8601 format."
  }
  validates :makes_unit, length: { maximum: 20 }
  validates :makes_unit, numericality: false
  validates_associated :ingredient_sets
  validate :presence_of_serves_or_makes
  validate :numericality_of_serves_or_makes

  before_save :set_image_url

  def title_with_no_accents
    remove_accents_from(title)
  end

  # The title of the recipe stripped of all commas, dots, apostrophes and accents
  def url_friendly_title
    removed_punctuation = remove_punctuation_from(title_with_no_accents)
    removed_punctuation.split.reject{ |i| CONNECTIVES.include? i }.join(" ")
  end

  def permalink
    "/#{url_friendly_title.downcase.split.join("-")}"
  end

  # This will generate the image in the proper format with dashes.
  # There are a number of older images that are with underscores instead however,
  # which will be handled by the check_photo_exists callback
  def image_url_with_dashes
    image_title = url_friendly_title.split.join("-").downcase 
    "https://s3.eu-west-2.amazonaws.com/grubdaily/#{image_title}.jpg"
  end 

  def image_url_with_underscores
    image_title = url_friendly_title.split.join("_").downcase 
    "https://s3.eu-west-2.amazonaws.com/grubdaily/#{image_title}.jpg"
  end

  def get_image_url
    with_underscores = request_image(image_url_with_underscores)
    with_dashes = request_image(image_url_with_dashes)

    if with_dashes == 200 
      image_url_with_dashes
    elsif with_underscores == 200
      image_url_with_underscores
    end
  end

  def rating_value
    [4, 4.5, 5].sample
  end

  def rating_count
    rand(20..98)
  end

  def ingredient_entries
    ingredient_sets.flat_map(&:ingredient_entries)
  end

  def serves_or_makes
    serves ? serves : "#{makes} #{makes_unit}"
  end

  def introduction_paragraphs
    introduction.split("\n")
  end

  private

  def set_image_url
    self.image_url = get_image_url if get_image_url
  end

  def remove_punctuation_from(string)
    string = string.gsub(/[\,\.']/, "")
  end

  def remove_accents_from(string)
    ActiveSupport::Inflector.transliterate(string)
  end

  # Extra model validations
  # Must have EITHER :serves OR :makes AND :makes_unit
  def presence_of_serves_or_makes
    if !serves && !makes
      errors.add(:makes, "cannot be blank if serves is also blank")
    elsif serves && makes
      errors.add(:makes, "cannot be present if serves is present")
    elsif makes && !makes_unit.present?
      errors.add(:makes_unit,  "must be present if makes is present")
    end
  end

  # Gets the status code for a given image url
  # if the status isn't 200 OK, then we assume the image doesn't exist
  def request_image(url)
    HTTParty.get(url).code
  end

  # :serves and :makes must both be numbers greater than 0. :makes_unit must NOT be a number
  def numericality_of_serves_or_makes
    errors.add(:serves, "must be greater than 0") if serves && serves <= 0
    errors.add(:makes, "must be geater than 0") if makes && makes <=0
    errors.add(:makes_unit, "cannot be a number") if  makes_unit && makes_unit.is_a?(Numeric)

    if serves && !serves.is_a?(Numeric)
      errors.add(:serves, "must be a number")
    elsif makes && !makes.is_a?(Numeric)
      errors.add(:makes, "must be a number")
    end
  end
end