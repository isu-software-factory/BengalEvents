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
  has_many :students , through: :registrations
   validates :start_time, uniqueness: true, presence: true
   validates :end_time, uniqueness: true, presence: true
  validates :capacity, presence: true
end
