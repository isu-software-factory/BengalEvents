class Registration < ApplicationRecord
  belongs_to :student
  belongs_to :event_detail
end
