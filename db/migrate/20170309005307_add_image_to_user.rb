class AddImageToUser < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :image, :binary, limit: 20.megabyte
  end

  def self.down
    remove_column :users, :image
  end
end
