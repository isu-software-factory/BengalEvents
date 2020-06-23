class Waitlist < ApplicationRecord
  belongs_to :session
  has_many :users
end
