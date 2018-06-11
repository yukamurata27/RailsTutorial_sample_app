class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    # manually add indices to the relationships table
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # あるユーザーが同じユーザーを2回以上フォローすることを防ぎます
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
