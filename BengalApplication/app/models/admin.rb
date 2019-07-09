class Admin < ApplicationRecord
  has_one :user, as: :Identifiable
end
