class Course < ApplicationRecord
  has_many :resources, dependent: :destroy
  has_many :deadlines, dependent: :destroy
  belongs_to :teacher

  validates :name, presence: true, length: { maximum: 50 }
  validates :summary, presence: true, length: { maximum: 200 }
  validates :code, presence: true, length: { maximum: 6 }, uniqueness: true
  validates :start_date, date: { after: Proc.new { Time.now }, before: Proc.new { Time.now+1.year } }
  validates :end_date, date: { after: Proc.new { Time.now+2.week }, before: Proc.new { Time.now+16.week } }
  validates :teacher_id, presence: true, allow_nil: true

  def to_param
    code
  end
end
