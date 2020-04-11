FactoryBot.define do
  factory :recipe, class: Recipe do
    title { "Onion Soup" }
    introduction { "an old French classic" }
    summary { "This is a rich and hearty soup from the classic French repertoire. It's one of my favourites." }
    total_time { "PT6H" }
    serves { 2 }
    makes { nil }
    recipe_type { "soup" }
    image_url { nil }
  end
end
