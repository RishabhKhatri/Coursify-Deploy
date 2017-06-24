class RemoveVerificationFromInstitutes < ActiveRecord::Migration[5.0]
  def change
    remove_column :institutes, :verified
  end
end
