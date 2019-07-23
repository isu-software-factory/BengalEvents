class EventDetail < ApplicationRecord
  belongs_to :event
  has_many :registrations
  has_many :participants , through: :registrations
   validates :start_time, uniqueness: true, presence: true
   validates :end_time, uniqueness: true, presence: true
  validates :capacity, presence: true
end
