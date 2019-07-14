class Teacher < ApplicationRecord
  has_one :user, as: :meta, dependent: :destroy
  has_many :students
  has_one :event_detail
  accepts_nested_attributes_for :user

  validates :school, presence: true
  validates :chaperone_count, presence: true
  validates :student_count, presence: true

end
