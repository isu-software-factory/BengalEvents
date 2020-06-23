class Room < ApplicationRecord
  belongs_to :location
  has_many :sessions

  validates :room_number, presence: true


end
