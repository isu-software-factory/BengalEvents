class Activity < ApplicationRecord
  belongs_to :event
  #belongs_to :location
  has_many :sessions, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

end
