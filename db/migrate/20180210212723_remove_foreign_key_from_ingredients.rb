class RemoveForeignKeyFromIngredients < ActiveRecord::Migration[5.1]
  def change
    change_table :ingredients do |t|
      t.remove :ingredient_entries_id
    end
  end
end
