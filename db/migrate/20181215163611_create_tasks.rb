class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :desc

      t.integer :project_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
