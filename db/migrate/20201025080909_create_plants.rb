class CreatePlants < ActiveRecord::Migration[6.0]
  def change
    create_table :plants do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :price_cents, null: false
      t.text :description

      t.timestamps
    end
  end
end
