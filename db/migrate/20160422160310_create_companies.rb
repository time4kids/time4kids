class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :owner
      t.string :email
      t.integer :phone
      t.string :website

      t.timestamps null: false
    end
  end
end
