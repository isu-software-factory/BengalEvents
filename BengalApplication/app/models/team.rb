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
  has_many :students, through: :groupings
  has_one :participant, as: :member, dependent: :destroy
  accepts_nested_attributes_for :participant

  validates :name, presence: true

# register a member (max 4) and return true if registered
  def register_member(student)
    # add student if count is less than 4
    if self.students.count < 4
      unless self.students.include?(student)
        self.students << student
        true
      end
    else
      false
    end
  end

end
