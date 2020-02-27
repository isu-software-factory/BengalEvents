class Location < ApplicationRecord
  has_many :rooms

  validates :location_name, presence: true

end
