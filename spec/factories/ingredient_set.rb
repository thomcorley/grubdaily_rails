FactoryBot.define do
  factory :ingredient_set, class: IngredientSet do
    title { "For the sauce" }
    position { 1 }
    recipe
  end
end
