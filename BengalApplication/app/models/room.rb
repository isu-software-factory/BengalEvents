class Room < ApplicationRecord
  belongs_to :location
  belongs_to :session
end
