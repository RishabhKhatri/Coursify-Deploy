class Resource < ApplicationRecord
  belongs_to :course
  mount_uploader :attachment, ResourceUploader
  validates :title, presence: true, length: { maximum: 50 }
  validates :instructions, length: { maximum: 100 }
  validates :course_id, presence: true, allow_nil: true
end
