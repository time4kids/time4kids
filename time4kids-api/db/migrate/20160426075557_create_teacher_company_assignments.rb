class CreateTeacherCompanyAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :user
      t.references :company

      t.timestamps null: false
    end
  end
end
