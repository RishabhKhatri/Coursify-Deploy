class CreateDeadlines < ActiveRecord::Migration[5.0]
  def change
    create_table :deadlines do |t|
      t.references :course, foreign_key: true
      t.string :title
      t.text :instructions
      t.string :attachment
      t.datetime :due_date
      t.string :link
      t.string :submission

      t.timestamps
    end
  end
end
