class ChangeDueDateInDeadlines < ActiveRecord::Migration[5.0]
  def change
    change_column :deadlines, :due_date, :date
    add_column :deadlines, :end_time, :time
  end
end
