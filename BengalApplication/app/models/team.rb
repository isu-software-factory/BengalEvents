# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  lead       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ApplicationRecord
  has_many :groupings
  has_many :users, through: :groupings
  has_many :team_registrations
  has_many :sessions, through: :team_registrations

  validates :team_name, presence: true
  validates :lead, presence: true

  #register a member (max 4) and return true if registered
  def register_member(student)
    # add student if count is less than 4
    if self.users.count < 4
      unless self.users.include?(student)
        self.users << student
        true
      else
        false
      end
    else
      false
    end
  end

  def get_lead
    User.find(self.lead)
  end
end
