class Teacher < ApplicationRecord
  has_one :user, as: :meta, dependent: :destroy
  has_one :participant, as: :member, dependent: :destroy
  has_many :students
  has_one :event_detail
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :participant
  validates :school, presence: true
  validates :chaperone_count, presence: true
  validates :student_count, presence: true
  validates :name, presence: true
end
