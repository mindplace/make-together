class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :body, null: false

      t.timestamps null: false
    end
    add_index :tags, :body, unique: true
  end
end
