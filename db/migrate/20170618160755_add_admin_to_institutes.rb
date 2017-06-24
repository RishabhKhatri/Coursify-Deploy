class AddAdminToInstitutes < ActiveRecord::Migration[5.0]
  def change
    add_column :institutes, :admin, :string
  end
end
