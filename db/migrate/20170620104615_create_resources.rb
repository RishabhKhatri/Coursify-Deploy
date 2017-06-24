class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.string :instructions
      t.references :course, foreign_key: true
      t.string :video
      t.string :attachment

      t.timestamps
    end
  end
end
