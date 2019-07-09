class Coordinator < ApplicationRecord
  has_one :user, as: :Identifiable
end
