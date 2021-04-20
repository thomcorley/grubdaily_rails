Rails.application.routes.draw do
  get "qrcode", to: redirect("menu")

  # Recipe Imports
  get "recipe_imports/new" => "recipe_imports#new"
  get "new_recipe" => "recipe_imports#new"
  post "recipe_imports/create" => "recipe_imports#create"
  get "recipe_imports/show" => "recipe_imports#show"
  resources :recipe_imports

  get "generate_jekyll_post" => "jekyll_posts#generate"
  get "touch_ingredient_entry/:id", to: "ingredient_entries#touch", as: "touch_ingredient_entry"

  # Home
  get "about" => "home#about"
  get "recipe_index" => "home#recipe_index"
  get "photos" => "home#photos"
  get "latest-entry" => "home#latest_entry"

  get "feed.xml"  => "entries#feed", format: "rss"
  get "feed"  => "entries#feed", format: "rss"

  # Orders
  get "menu" => "orders#new"
  resources :orders

  # Dynamic routes
  get "/:recipe_path" => "recipes#show"
  get "/posts/:blog_post_path" => "blog_posts#show"

  resources :blog_posts do
    collection do
      get "publish"
      get "unpublish"
      get "test_email"
      get "bulk_send_emails"
    end
  end

  resources :contact_form_messages

  get "contact_form/confirmation" => "contact_form_messages#confirmation"

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

  # Recipes
  get "feed.xml"  => "entries#feed", format: "rss"
  get "feed"  => "entries#feed", format: "rss"

  resources :recipes do
    collection do
      get "publish"
      get "unpublish"
      get "test_email"
      get "bulk_send_emails"
    end
  end

  # Redirects
  get "/chocolate/chocolate_mousse", to: redirect("chocolate-mousse")
  get "/soup/chicken_and_coriander_broth", to: redirect("chicken-coriander-broth")
  get "/dessert/peanut_caramel_cheesecake", to: redirect("peanut-caramel-cheesecake")
  get "/fish/cod_with_cockles_a_la_creme", to: redirect("cod-cockles-creme")
  get "/pork/pork_belly_asparagus_and_ale_sauce", to: redirect("pork-belly-asparagus-ale-sauce")
  get "/blog/barley-risotto-with-chicken", to: redirect("barley-risotto-chicken")
  get "/blog/salmon-and-hollandaise", to: redirect("salmon-hollandaise")
  get "/blog/confit-duck", to: redirect("duck-rilettes")
  get "/2011/09/peanut-butter-and-jam-creme-brulee", to: redirect("peanut-butter-jam-creme-brulee")
  get "/2011/09/peanut-butter-millionaire-shortbread", to: redirect("peanut-butter-caramel-shortbread")

  root :to => "home#index"
end
