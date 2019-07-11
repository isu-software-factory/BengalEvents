class EventDetail < ApplicationRecord
  belongs_to :event
  has_many :registration
  has_many :students , through: :registration
end
