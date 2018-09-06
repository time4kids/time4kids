class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.references :school, index: true, foreign_key: true, null: true
      t.integer :level, null: false
      t.integer :age, null: false
      t.integer :duration
      t.date :start_date, null: false
      t.date :end_date
      t.timestamps :start_time, null: false
      t.string :language

      t.timestamps null: false
    end
  end
end
