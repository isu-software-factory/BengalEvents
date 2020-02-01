class Location < ApplicationRecord
  has_many :rooms
  belongs_to :session
end
