class Sponsor < ApplicationRecord
  has_one :user, as: :Identifiable
end
