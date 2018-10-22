# frozen_string_literal: true

class AddProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :profile, polymorphic: true, index: true
  end
end
