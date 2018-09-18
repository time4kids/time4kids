# frozen_string_literal: true

class CreateStudentProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :student_profiles do |t|
      t.string :phone
      t.references :address, foreign_key: true, index: true
      t.integer :age
      t.string :gender
    end
  end
end
