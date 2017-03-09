class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :content
      t.boolean :seen, default: false
      t.references :ref_user, foreign_key: { to_table: :users }
      t.references :ref_recipe, foreign_key: { to_table: :recipes }
      t.belongs_to :user, foreign_key: true
    end
  end
end
