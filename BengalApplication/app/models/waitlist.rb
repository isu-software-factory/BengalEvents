class Waitlist < ApplicationRecord
  belongs_to :event_detail
  has_many :participants
end
