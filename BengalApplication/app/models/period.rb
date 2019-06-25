class Period < ApplicationRecord
  belongs_to :event
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :capacity, presence: true

end
