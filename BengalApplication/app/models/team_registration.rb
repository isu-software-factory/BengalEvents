class TeamRegistration < ApplicationRecord
  belongs_to :session
  belongs_to :team
end
