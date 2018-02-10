class Recipe < ApplicationRecord
  has_many :ingredient_sets
  has_many :method_steps
  has_many :tags, :as => :taggable
end
