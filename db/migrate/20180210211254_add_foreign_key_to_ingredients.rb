class AddForeignKeyToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_reference :ingredients, :ingredient_entries, foreign_key: true
  end
end
