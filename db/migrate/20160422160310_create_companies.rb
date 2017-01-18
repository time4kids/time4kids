class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :email
      t.integer :phone
      t.string :website
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
