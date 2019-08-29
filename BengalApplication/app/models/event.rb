# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string
#  location    :string
#  description :text
#  isMakeAhead :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  occasion_id :integer
#  sponsor_id  :integer
#

class Event < ApplicationRecord
  belongs_to :occasion
  belongs_to :supervisor
  has_many :event_details, dependent: :destroy
  belongs_to :location
  validates :name, presence: true
  validates :description, presence: true
  # validates :isMakeAhead, presence: true
  #
  #
end
