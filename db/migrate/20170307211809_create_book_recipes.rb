class CreateBookRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :book_recipes do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :recipe, foreign_key: true
    end
  end
end
