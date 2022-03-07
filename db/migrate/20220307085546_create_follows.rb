class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.bigint :follower_id, foreign_key: true
      t.bigint :following_id, foreign_key: true

      t.timestamps
      end

      add_index :follows, :follower_id
      add_index :follows, :following_id
      add_index :follows, [:follower_id, :following_id], unique: true
  end
end
