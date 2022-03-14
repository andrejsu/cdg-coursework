class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :likeable_id, null: false, foreign_key: true
      t.string :likeable_type

      t.timestamps
    end

    add_index :likes, [:likeable_id, :likeable_type]
    add_index :likes, [:user_id, :likeable_id, :likeable_type], unique: true
  end
end
