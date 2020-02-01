class Waitlist < ApplicationRecord
  has_many :users
  belongs_to :session
end
