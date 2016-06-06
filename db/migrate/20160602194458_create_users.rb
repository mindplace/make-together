class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :first_name
      t.string :last_name
      t.string :role
      t.text :bio
      t.string :img

      t.string :github
      t.string :github_uid
      t.string :github_url

      t.string :dribbble
      t.string :dribbble_uid
      t.string :dribbble_url

      t.timestamps null: false
    end

    add_index :users, :email, unique: true

  end
end
