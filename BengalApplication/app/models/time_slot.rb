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
  belongs_to :event
  belongs_to :location
end
