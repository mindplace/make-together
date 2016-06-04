class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversation, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
