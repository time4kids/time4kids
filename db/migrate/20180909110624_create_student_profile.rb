class CreateStudentProfile < ActiveRecord::Migration[5.2]
  def change
    create_table :student_profiles do |t|
      t.string :phone
      t.references :address, foreign_key: true
      t.integer :age
    end
  end
end
