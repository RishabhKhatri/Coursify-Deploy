class ModifyDurationToCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses, :duration
    add_column :courses, :start_date, :date
    add_column :courses, :end_date, :date
  end
end
