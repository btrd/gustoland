class AddImageToRecipe < ActiveRecord::Migration[5.0]
  def self.up
    add_column :recipes, :image, :binary, limit: 20.megabyte
  end

  def self.down
    remove_column :recipes, :image
  end
end
