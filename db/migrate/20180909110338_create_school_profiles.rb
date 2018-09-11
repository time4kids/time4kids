class CreateSchoolProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :school_profiles do |t|
      t.string :name
      t.string :phone
      t.string :website
      t.text :description
      t.references :address, foreign_key: true
    end
  end
end
