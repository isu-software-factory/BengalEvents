class Student < ApplicationRecord
  has_one :user, as: :Identifiable, dependent: :destroy
  has_many :registrations
  has_many :event_details, through: :registrations

end
