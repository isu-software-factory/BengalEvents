class Student < ApplicationRecord
  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user
  has_many :registrations
  has_many :event_details, through: :registrations

end
