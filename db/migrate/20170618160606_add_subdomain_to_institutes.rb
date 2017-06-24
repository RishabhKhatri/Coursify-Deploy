class AddSubdomainToInstitutes < ActiveRecord::Migration[5.0]
  def change
    add_column :institutes, :subdomain, :string
  end
end
