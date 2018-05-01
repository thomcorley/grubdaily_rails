class RemoveIngredientIdFromIngredientEntries < ActiveRecord::Migration[5.1]
  def change
  	remove_column :ingredient_entries, :ingredient_id, :integer
  end
end
