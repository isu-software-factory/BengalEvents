# == Schema Information
#
# Table name: registrations
#
#  id              :integer          not null, primary key
#  student_id      :integer
#  event_detail_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Registration < ApplicationRecord
  belongs_to :event_detail
  belongs_to :participant
  validates  :event_detail_id, :uniqueness => {:scope => :participant_id, :message => "You have already registered on this event."}
end
