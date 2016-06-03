class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :body, null: false

      t.timestamps null: false
    end
    add_index :skills, :body, unique: true
  end
end
