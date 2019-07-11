class Sponsor < ApplicationRecord
  has_one :user, as: :Identifiable
  has_many :events
end
