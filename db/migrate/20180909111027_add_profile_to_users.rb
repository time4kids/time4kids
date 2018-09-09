class AddProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :profile, polymorfic: true, foreign_key: true
  end
end
