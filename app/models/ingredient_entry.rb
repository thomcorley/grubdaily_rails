class IngredientEntry < ApplicationRecord
  belongs_to :ingredient_set
  validates :ingredient, presence: true
  alias_attribute :name, :ingredient

  def human_readable_entry
    HumanReadableEntryGenerator.new(self).generate
  end
end
