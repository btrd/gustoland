class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :description
      t.integer :price
      t.integer :time
      t.integer :serving
      t.date :publication

      t.timestamps
    end
  end
end
