class IngredientSet < ApplicationRecord
  has_many :ingredient_entries
  belongs_to :recipe
  validate :length_of_title_if_present
  validates_associated :ingredient_entries

  private
  # Extra model validations
  def length_of_title_if_present
    errors.add(:title, "cannot be longer that 30 characters") if title && title.length > 30
  end
end
