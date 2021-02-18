class Recipe < ApplicationRecord
  include TitleFormatter

  # This is the ISO 8601 standardised time format
  TIME_FORMAT_REGEX = /P(\d{1,2}D)?(T\d{1,2}(H|M))?(\d{1,2}(H|M))?/
  CONNECTIVES = %w(and with of au a la)
  PUNCTUATION = %w(' " , - )

  has_many :ingredient_sets, dependent: :destroy
  has_many :method_steps, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 50 }
  validates :total_time, format: { :with => TIME_FORMAT_REGEX,
    :message => "total_time must be in valid ISO 8601 format."
  }
  validates :makes_unit, length: { maximum: 20 }
  validates :makes_unit, numericality: false
  validates_associated :ingredient_sets
  validate :presence_of_serves_or_makes
  validate :numericality_of_serves_or_makes

  scope :published, -> { where("recipes.published_at IS NOT NULL") }

  # TODO: make this a common method
  def self.get(permalink)
    Recipe.select{ |recipe| recipe.permalink == "/#{permalink}"}.first
  end

  def image
    url_friendly_title.parameterize
  end

  # TODO: make this a common method
  def rating_value
    [4, 4.5, 5].sample
  end

  # TODO: make this a common method
  def rating_count
    rand(20..98)
  end

  def ingredient_entries
    IngredientEntry
      .where(ingredient_set_id: self.ingredient_sets.map(&:id))
      .order(id: :asc)
  end

  def serves_or_makes
    serves ? serves : "#{makes} #{makes_unit}"
  end

  # TODO: make this a common method and rename
  def introduction_paragraphs
    introduction.split("\n")
  end

  # TODO: make this a common method
  def publish!
    self.update!(published_at: DateTime.now, published: true)
  end

  # TODO: make this a common method
  def unpublish!
    self.update!(published: false)
  end

  # TODO: make this a common method
  def excerpt
    "#{introduction.first(140)} ..."
  end

  # TODO: make this a common method
  def permalink
    "/#{url_friendly_title.downcase.split.join("-")}"
  end

  def ingredients_array
    ingredient_entries.map(&:original_string)
  end

  def method_steps_array
    method_steps.map(&:description)
  end

  private

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

  # TODO: make this a common method
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
