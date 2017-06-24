class AddVerificationToInstitutes < ActiveRecord::Migration[5.0]
  def change
    add_column :institutes, :verified, :boolean, default: false
  end
end
