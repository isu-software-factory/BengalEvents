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

# register participant to event detail
# Makes sure that participant isn't already registered
  def register_participant(participant)
    unless self.participants.include?(participant)
      unless self.capacity_remaining == 0
        self.participants << participant
        true
      end
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
