class Location < ApplicationRecord
  has_many :rooms, dependent: :destroy

  validates :location_name, presence: true

end
