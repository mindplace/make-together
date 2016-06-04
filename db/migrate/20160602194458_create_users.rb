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
      t.string :projects_url

      t.string :provider
      t.string :uid

      t.timestamps null: false
    end

    add_index :users, :email, unique: true

  end
end
