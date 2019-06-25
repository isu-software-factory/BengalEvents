class Event < ApplicationRecord
  belongs_to :occasion
  has_many :sessions
  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :isMakeAhead, presence: true
end
