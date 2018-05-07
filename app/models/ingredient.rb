class Ingredient < ApplicationRecord
  belongs_to :ingredient_entry

  validates :name, presence: true

  private
  # Extra model validations
end
