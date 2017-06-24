class Institute < ApplicationRecord
  has_many :teachers
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
end
