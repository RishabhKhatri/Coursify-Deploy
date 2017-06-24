class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :summary
      t.string :code
      t.time :duration
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
