Rails.application.routes.draw do
  get "recipe_imports/new" => "recipe_imports#new"

  post "recipe_imports/create" => "recipe_imports#create"

  get "recipe_imports/show" => "recipe_imports#show"

  get "generate_jekyll_post" => "jekyll_posts#generate"

  get "touch_ingredient_entry/:id", to: "ingredient_entries#touch", as: "touch_ingredient_entry"

  get "new_recipe" => "recipe_imports#new"

  get "about" => "home#about"

  get "recipe_index" => "home#recipe_index"

  get "/:recipe_path" => "recipes#show"

  resources :ingredient_entries
  resources :ingredients
  resources :ingredient_sets

  resources :recipes do
    collection do
      get "publish"
      get "unpublish"
    end
  end

  resources :recipe_imports
  resources :method_steps

  root :to => "home#index"
end
