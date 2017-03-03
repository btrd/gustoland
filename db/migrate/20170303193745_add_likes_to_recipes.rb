class AddLikesToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :likes, :integer, default: 0
  end
end
