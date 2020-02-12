class Room < ApplicationRecord
  belongs_to :location
  belongs_to :session

  validates :room_number, presence: true


end
