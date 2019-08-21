class Supervisor < ApplicationRecord
  belongs_to :director, polymorphic: true
  has_many :events
end
