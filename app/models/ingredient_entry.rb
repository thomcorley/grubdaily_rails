class IngredientEntry < ApplicationRecord
  belongs_to :ingredient_set
  has_one :ingredient
  validates_associated :ingredient
  delegate :name, to: :ingredient
end

private
