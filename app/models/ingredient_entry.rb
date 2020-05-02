class IngredientEntry < ApplicationRecord
  belongs_to :ingredient_set
  validates :ingredient, presence: true
  alias_attribute :name, :ingredient
end
