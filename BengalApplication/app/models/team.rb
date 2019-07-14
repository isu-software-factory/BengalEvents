class Team < ApplicationRecord
  has_many :groupings
  has_many :students, through: :groupings
end
