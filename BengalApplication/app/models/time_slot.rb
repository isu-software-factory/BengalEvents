# == Schema Information
#
# Table name: time_slots
#
#  id          :integer          not null, primary key
#  start_time  :datetime
#  end_time    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :integer
#  location_id :integer
#

class TimeSlot < ApplicationRecord
  belongs_to :location
  validate :no_reservation_overlap
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :interval, presence: true

  def no_reservation_overlap
    result = TimeSlot.joins(:location => :occasion).where(locations: {name: location.name}).where(start_time: start_time...end_time) or
        (where(end_time: start_time...end_time)).where(locations: {occasions: {start_date: location.occasion.start_date..location.occasion.end_date}}).or(where(locations: {occasions: {end_date: location.occasion.start_date...location.occasion.end_date}}))
    errors.add(:location, 'overlaps another reservation') if result.length > 0
  end

  validate :end_must_be_after_start

  def end_must_be_after_start
    if self.start_time != nil && self.end_time != nil
      if self.start_time >= self.end_time
        errors.add(:end_time, "must be after start time")
      end
    end
  end
end
