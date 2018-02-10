class AddIngredientSetIdToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :ingredient_set_id, :integer
  end
end
