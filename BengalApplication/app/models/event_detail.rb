class EventDetail < ApplicationRecord
  belongs_to :event
  has_many :registrations
  has_many :students , through: :registrations
  belongs_to :teacher
end
