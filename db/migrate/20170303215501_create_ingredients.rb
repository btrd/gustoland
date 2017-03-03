class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.string :label
      t.integer :quantity
      t.string :unit
      t.belongs_to :recipe,  foreign_key: true
    end
  end
end
