class Event < ApplicationRecord
  has_many :activities, dependent: :destroy
  # accepts_nested_attributes_for :activities, allow_destroy: true
  validates :name, :start_date, presence: true
  validates :description, presence: true
end
