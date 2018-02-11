class IngredientEntry < ApplicationRecord
  belongs_to :ingredient_set
  has_one :ingredient

  validates :quantity, presence: true
  validate :modifier_is_downcase?
end

private
# Extra model validations
def modifier_is_downcase?
  errors.add(:modifier, "must be lower case") unless modifier == modifier.downcase
end
