class AddForeignKeyToIngredientEntries < ActiveRecord::Migration[5.1]
  def change
    # add_reference :ingredient_entries, :ingredient, foreign_key: true
  end
end
