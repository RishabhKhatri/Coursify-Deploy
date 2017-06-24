class Deadline < ApplicationRecord
  extend TimeSplitter::Accessors
  belongs_to :course
  mount_uploader :attachment, DeadlineUploader
  validates :title, presence: true, length: { maximum: 50 }
  validates :instructions, length: { maximum: 200 }
  validates :course_id, presence: true, allow_nil: true
  validates :due_date, presence: true, allow_nil: true, date: { after: Proc.new { Time.now } }
  split_accessor :due_date
end
