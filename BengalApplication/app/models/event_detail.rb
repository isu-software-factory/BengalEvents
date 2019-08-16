# == Schema Information
#
# Table name: event_details
#
#  id         :integer          not null, primary key
#  capacity   :integer
#  start_time :datetime
#  end_time   :datetime
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventDetail < ApplicationRecord
  belongs_to :event
  has_many :registrations
  has_many :participants, through: :registrations
  validates :start_time, :end_time,  presence: true
  validates_uniqueness_of :start_time, :end_time
  validates :capacity, presence: true
  validates :date_started, presence: true
  validate :end_must_be_after_start

  def end_must_be_after_start
    if self.start_time != nil && self.end_time != nil
      if self.start_time >= self.end_time
        errors.add(:end_time, "must be after start time")
      end
    end
  end
# register participant to event detail
# Makes sure that participant isn't already registered and that the capacity is zero
  def register_participant(participant)
    unless self.participants.include?(participant)
      unless self.capacity_remaining == 0
        self.participants << participant
        true
      else
        false
      end
    else
      false
    end
  end

  # Capacity remaining for event detail
  def capacity_remaining
    # Go through participants to decrease capacity
    @remaining = self.capacity
    self.participants.each do |p|
      if p.member_type == "Team"
        # team members
        members = p.member.students.count
        @remaining -= members
      else
        @remaining -= 1
      end
    end
    @remaining
  end


end
