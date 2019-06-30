class Event < ApplicationRecord
  belongs_to :occasion
  has_many :periods, dependent: :destroy
  # validates :name, presence: true
  # validates :location, presence: true
  # validates :description, presence: true
  # validates :isMakeAhead, presence: true
end
