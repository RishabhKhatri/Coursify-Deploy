class AddInstituteToTeachers < ActiveRecord::Migration[5.0]
  def change
    add_reference :teachers, :institute, foreign_key: true
  end
end
