class Ingredient < ApplicationRecord
  belongs_to :ingredient_entry

  validates :name, presence: true
  validate :name_is_capitalized

  private
  # Extra model validations
  def name_is_capitalized
    errors.add(:name, "Must be capitalized") unless name == name.capitalize
  end
end
