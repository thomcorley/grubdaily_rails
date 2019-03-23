FactoryBot.define do
  factory :recipe, class: Recipe do
    title "Onion Soup"
    introduction "an old French classic"
    total_time "4 hours"

    transient do
      salty { true }

      after(:create) do |recipe, evaluator|
        recipe.update_attribute(:title, "Salty " + recipe.title)
      end
    end
  end
end