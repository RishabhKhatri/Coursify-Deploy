class AddPictureToTeachers < ActiveRecord::Migration[5.0]
  def change
    add_column :teachers, :picture, :string
  end
end
