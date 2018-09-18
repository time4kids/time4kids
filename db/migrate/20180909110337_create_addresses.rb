# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :country, null: false
      t.string :region, null: true
      t.string :city, null: false
      t.string :street, null: false
      t.string :number, null: true
      t.integer :postal_code, null: true
      t.float :lat, null: true, limit: 30
      t.float :long, null: true, limit: 30
    end
  end
end
