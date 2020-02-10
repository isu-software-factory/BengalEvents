class Activity < ApplicationRecord
  belongs_to :event
  #belongs_to :location
  has_many :sessions
  accepts_nested_attributes_for :sessions, allow_destroy: true

  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true

end
