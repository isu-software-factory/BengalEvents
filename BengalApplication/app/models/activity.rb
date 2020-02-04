class Activity < ApplicationRecord
  belongs_to :event
  #belongs_to :location
  has_many :sessions, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true

end
