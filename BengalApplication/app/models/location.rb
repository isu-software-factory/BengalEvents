# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  start_time  :datetime
#  end_time    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  occasion_id :integer
#

class Location < ApplicationRecord
  belongs_to :occasion
  has_many :time_slots, dependent: :destroy
  has_many :events
  validates :name, uniqueness: true, presence: true
  accepts_nested_attributes_for :time_slots, allow_destroy: true,
                                reject_if: ->(attrs) {attrs['interval'].blank? }

end

