class EventDetail < ApplicationRecord
  belongs_to :event
  has_many :registrations
  has_many :students , through: :registrations
  # validates :start_time, uniqueness: true
  # validates :end_time, uniqueness: true
end
