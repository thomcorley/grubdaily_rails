class AddForiegnKeyToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_reference :ingredients, :ingredient_entry, foreign_key: true
  end
end
