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
  belongs_to :session
  belongs_to :user

  def register_participant(participant)
    unless self.users.include?(participant)
      unless self.capacity_remaining == 0
        self.users << participant
        #send_make_ahead(participant)
        true
      else
        false
      end
    else
      false
    end
  end

end
