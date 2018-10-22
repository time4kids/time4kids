# frozen_string_literal: true

class CreateJoinTableSchoolCategory < ActiveRecord::Migration[5.2]
  def change
    create_join_table :school_profiles, :categories, table_name: 'school_categories' do |t|
      t.index [:school_profile_id, :category_id], name: 'school_profile_index'
      t.index [:category_id, :school_profile_id], name: 'category_index'
    end
  end
end
