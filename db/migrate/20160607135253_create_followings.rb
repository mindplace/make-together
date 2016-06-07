class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :followed_user_id, foreign_key: :true
      t.integer :follower_id, foreign_key: :true

      t.timestamps null: false
    end
  end
end
