class IngredientEntry < ApplicationRecord
  belongs_to :ingredient_set
  has_one :ingredient
end
