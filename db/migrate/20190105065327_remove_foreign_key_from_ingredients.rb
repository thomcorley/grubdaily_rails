class RemoveForeignKeyFromIngredients < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :ingredients, :ingredient_entries
  end
end
