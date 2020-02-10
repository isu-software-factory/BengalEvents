class Room < ApplicationRecord
  belongs_to :location
  belongs_to :session

  validates :room_number, presence: true
    #validates :room_name, presence: false
end
