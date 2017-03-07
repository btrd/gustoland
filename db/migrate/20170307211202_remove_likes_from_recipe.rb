class RemoveLikesFromRecipe < ActiveRecord::Migration[5.0]
  def change
    remove_column :recipes, :likes, :integer
  end
end
