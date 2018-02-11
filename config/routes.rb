Rails.application.routes.draw do
  get 'ingredient/index'

  get 'ingredient/create'

  get 'ingredient/show'

  get 'ingredient/new'

  get 'ingredient/update'

  get 'ingredient/delete'

  resources :ingredient_entries
  resources :ingredient_sets
  resources :recipes
  resources :full_recipes

  root :to => 'index#index'
end
