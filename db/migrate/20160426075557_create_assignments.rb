class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.reference :user
      t.reference :role

      t.timestamps null: false
    end
  end
end
