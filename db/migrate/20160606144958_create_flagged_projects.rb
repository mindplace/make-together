class CreateFlaggedProjects < ActiveRecord::Migration
  def change
    create_table :flagged_projects do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps null: false
    end
  end
end
