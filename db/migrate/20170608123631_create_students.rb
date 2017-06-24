class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email, unique: true, index: true
      t.string :contact, unique: true
      t.string :password_digest
      t.string :picture
      t.string :provider
      t.string :uid
      t.boolean :admin, default: false
      t.string :imglink
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.date :dob

      t.timestamps
    end
  end
end
