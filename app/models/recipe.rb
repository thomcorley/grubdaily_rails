class Recipe < ApplicationRecord
  # This is the ISO 8601 standardised time format
  TIME_FORMAT_REGEX = /P(\d{1,2}D)?(T\d{1,2}(H|M))?(\d{1,2}(H|M))?/
  CONNECTIVES = %w(and with of au a la)

  has_many :ingredient_sets
  has_many :method_steps
  has_many :tags, as: :taggable

  validates :title, presence: true
  validates :title, length: { maximum: 50 }
  validates :summary, length: { maximum: 150 }
  validates :introduction, presence: true
  validates :total_time, format: { :with => TIME_FORMAT_REGEX,
    :message => "total_time must be in valid ISO 8601 format."
  }
  validate :presence_of_serves_or_makes
  validate :numericality_of_serves_or_makes
  validates :makes_unit, length: { maximum: 20 }
  validates :makes_unit, numericality: false

  def permalink
    stripped_title = title.split.reject{ |i| CONNECTIVES.include? i }.join(" ")
    "/#{stripped_title.downcase.split.join("-")}"
  end

  def image_url
    "https://s3.eu-west-2.amazonaws.com/grubdaily#{permalink}.jpg"
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
  # Extra model validations
  #
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