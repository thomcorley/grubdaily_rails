class RemoveIngredientIdFromIngredientEntries < ActiveRecord::Migration[5.1]
  def change
    change_column :ingredient_entries do |t|
      t.remove :ingredient_id
    end
  end
end
