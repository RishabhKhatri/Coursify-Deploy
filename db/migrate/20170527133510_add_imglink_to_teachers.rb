class AddImglinkToTeachers < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :imglink, :string
  end
end
