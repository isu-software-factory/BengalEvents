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
end
