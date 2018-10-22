# frozen_string_literal: true

class AddProfileToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :addressable, polymorphic: true, index: true
  end
end
