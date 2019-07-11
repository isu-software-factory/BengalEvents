class Occasion < ApplicationRecord
  has_many :events, dependent: :destroy
  belongs_to :coordinator
  validates :name, presence: true
   validates :start_date, presence: true
   validates :end_date, presence: true
   validates :name, :start_date, :end_date, presence: true
end
