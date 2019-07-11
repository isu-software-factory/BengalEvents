class EventDetail < ApplicationRecord
  belongs_to :event, dependent: :destroy
  has_many :students , through: :registration
end
