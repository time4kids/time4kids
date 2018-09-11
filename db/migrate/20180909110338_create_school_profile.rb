class CreateSchoolProfile < ActiveRecord::Migration[5.2]
  def change
    create_table :school_profiles do |t|
      t.string :name
      t.string :phone
      t.string :web_site
      t.text :description
      t.references :address, foreign_key: true
    end

    add_index :student_profiles, :address
  end
end
