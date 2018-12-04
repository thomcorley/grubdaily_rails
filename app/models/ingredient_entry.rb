class IngredientEntry < ApplicationRecord
  belongs_to :ingredient_set
  has_one :ingredient
  validates_associated :ingredient
  validates :ingredient, presence: true
  delegate :name, to: :ingredient
end

private
