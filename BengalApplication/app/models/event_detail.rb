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
  validates_uniqueness_of :start_time, :end_time, :scope => [:location]
  validates :capacity, :location, presence: true

# register participant to event detail
# Makes sure that participant isn't already registered
  def register_participant(participant)
    unless self.participants.include?(participant)
      self.participants << participant
      true
    else
      false
    end
  end

end
