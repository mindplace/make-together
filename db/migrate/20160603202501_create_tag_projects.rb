class CreateTagProjects < ActiveRecord::Migration
  def change
    create_table :tag_projects do |t|
      t.references :tag, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps null: false
    end
  end
end
