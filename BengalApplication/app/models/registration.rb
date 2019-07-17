class Registration < ApplicationRecord
  belongs_to :student
  belongs_to :event_detail
  # validates :student, uniqueness: true
  # validates :event_detail, uniqueness: true

  validates_uniqueness_of :event_detail, scope: :student
end
