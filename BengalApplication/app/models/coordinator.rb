class Coordinator < ApplicationRecord
  has_one :user, as: :Identifiable, dependent: :destroy
end
