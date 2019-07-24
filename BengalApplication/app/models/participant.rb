class Participant < ApplicationRecord
  belongs_to :member, polymorphic: true
  has_many :registrations
  has_many :event_details, through: :registrations
end
