class CreatePlantCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :plant_categories do |t|
      t.references :plant, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
