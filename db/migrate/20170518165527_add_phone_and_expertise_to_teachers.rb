class AddPhoneAndExpertiseToTeachers < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :contact, :string, unique: true
    add_column :teachers, :expertise, :string
  end
end
