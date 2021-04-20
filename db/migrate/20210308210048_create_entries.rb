class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.string :title
      t.text :summary
      t.text :content
      t.string :tags
      t.text :images
      t.boolean :published
      t.datetime :published_at
      t.string :total_time
      t.integer :serves
      t.integer :makes
      t.string :makes_unit
      t.string :recipe_type
      t.string :category
    end
  end
end
