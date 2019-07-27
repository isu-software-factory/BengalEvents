class Team < ApplicationRecord
  has_many :groupings
  has_many :students, through: :groupings
  has_one :participant, as: :member, dependent: :destroy
  accepts_nested_attributes_for :participant

  validates :name, presence: true
end
