class CreateSkillUsers < ActiveRecord::Migration
  def change
    create_table :skill_users do |t|
      t.references :skill, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
