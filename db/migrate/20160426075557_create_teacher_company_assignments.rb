class CreateTeacherCompanyAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.reference :user
      t.reference :company

      t.timestamps null: false
    end
  end
end
