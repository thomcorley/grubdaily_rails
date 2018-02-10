class IngredientSet < ApplicationRecord
  has_many :ingredient_entries
  belongs_to :recipe
end
