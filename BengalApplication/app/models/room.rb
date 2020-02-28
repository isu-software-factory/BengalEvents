class Room < ApplicationRecord
  belongs_to :location
  has_one :session

  validates :room_number, presence: true


end
