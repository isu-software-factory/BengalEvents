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
  # validates :student, uniqueness: true
  # validates :event_detail, uniqueness: true

  #validates_uniqueness_of :event_detail, scope: :student
end
