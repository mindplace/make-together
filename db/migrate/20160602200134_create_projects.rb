class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :expiration
      t.string :tagline
      t.boolean :flagged, default: false
      t.references :user


      t.timestamps null: false
    end
  end
end
