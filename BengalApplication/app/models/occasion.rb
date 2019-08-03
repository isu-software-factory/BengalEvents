# == Schema Information
#
# Table name: occasions
#
#  id             :integer          not null, primary key
#  name           :string
#  start_date     :datetime
#  end_date       :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  coordinator_id :integer
#  description    :string
#

class Occasion < ApplicationRecord
  has_many :events, dependent: :destroy
  belongs_to :coordinator
  has_many :locations
  validates :name, :start_date, :end_date, presence: true
  accepts_nested_attributes_for :locations
  # has one location
  # Reference Occasion will have location id
  # Time slots Object start_time end_time
  # Location reference to Time slots// Time slots model location id
  # location has many time slots

end
