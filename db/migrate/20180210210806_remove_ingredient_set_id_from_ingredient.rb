class RemoveIngredientSetIdFromIngredient < ActiveRecord::Migration[5.1]
  def change
    change_table :ingredients do |t|
      t.remove :ingredient_set_id
    end
  end
end
