class Location < ApplicationRecord
  has_many :rooms

  validates :location_name, :address, presence: true

end
