class Event < ApplicationRecord
  belongs_to :occasion
  belongs_to :sponsor
  has_many :event_details, dependent: :destroy

  # validates :name, presence: true
  # validates :location, presence: true
  # validates :description, presence: true
  # validates :isMakeAhead, presence: true
end
