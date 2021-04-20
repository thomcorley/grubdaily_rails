FactoryBot.define do
  factory :recipe, class: Recipe do
    title { "Berber Omelette" }
    content { "An old French classic, this is truly an old school soup. It is rich and dark with beef stock and, if made correctly, should be very thick." }
    summary { "This is a rich and hearty soup from the classic French repertoire. It's one of my favourites." }
    total_time { "PT6H" }
    serves { 2 }
    makes { nil }
    recipe_type { "soup" }
    images { nil }

    # TODO: this does not seem to work. Please fix!
    # after(:create) do |recipe, _evaluator|
    #   ingredient_set = FactoryBot.create(:ingredient_set, recipe: recipe)
    #   FactoryBot.create_list(:ingredient_entry, 2, ingredient_set: ingredient_set)
    # end
  end
end
