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

  get "/posts/:blog_post_path" => "blog_posts#show"

  resources :blog_posts do
    collection do
      get "publish"
      get "unpublish"
    end
  end

  resources :email_subscribers do
    member do
      get :delete
      get :send_confirmation
      get :confirm
    end
  end

  resources :ingredient_entries
  resources :ingredients
  resources :ingredient_sets
  resources :method_steps
  resources :recipe_imports

  resources :recipes do
    collection do
      get "publish"
      get "unpublish"
    end
  end


  root :to => "home#index"
end
