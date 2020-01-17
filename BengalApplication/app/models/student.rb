# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  teacher_id :integer
#  name       :string
#

class Student < ApplicationRecord
  has_one :user, as: :meta, dependent: :destroy
  has_one :participant, as: :member, dependent: :destroy
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :participant
  # has_many :event_details, through: :registrations
  belongs_to :teacher
  has_many :groupings
  has_many :teams, through: :groupings
  validates :name, presence: true


end
