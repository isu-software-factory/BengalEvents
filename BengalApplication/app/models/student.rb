class Student < ApplicationRecord
  has_one :user, as: :meta, dependent: :destroy
  has_one :participant, as: :member, dependent: :destroy
  accepts_nested_attributes_for :user
  has_many :registrations
  has_many :event_details, through: :registrations
  belongs_to :teacher
  has_many :groupings
  has_many :team, through: :groupings
  validates :name, presence: true
end
