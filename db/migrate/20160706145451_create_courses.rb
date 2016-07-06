class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.references :user, index: true, foreign_key: true, null: false
      t.references :company, index: true, foreign_key: true, null: true
      t.integer :start_age
      t.integer :end_age
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
