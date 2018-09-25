# frozen_string_literal: true

class CreateSchoolProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :school_profiles do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.string :website
      t.text :description, null: false
      t.references :address, foreign_key: true
    end
  end
end
