class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :body, null: false
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
