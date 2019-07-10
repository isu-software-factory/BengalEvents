class EventDetail < ApplicationRecord
  belongs_to :event
  has_many :students , through: :registration
end
