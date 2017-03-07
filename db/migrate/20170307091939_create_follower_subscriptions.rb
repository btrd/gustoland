class CreateFollowerSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :follower_subscriptions do |t|
      t.references :follower, index: true, foreign_key: { to_table: :users }
      t.references :followed, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
