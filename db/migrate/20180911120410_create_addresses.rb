class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :country, null: false
      t.string :region, null: true
      t.string :city, null: false
      t.string :street, null: false
      t.string :number, null: true
      t.integer :postal_code, null: true
      t.double :lat, null: true
      t.double :long, null: true
    end
  end
end
