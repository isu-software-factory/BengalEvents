class Registration < ApplicationRecord
  belongs_to :student
  belongs_to :event_detail
  validates :student, uniqueness: true
  validates :event_detail, uniqueness: true

end
