class Student < ApplicationRecord
  has_one :user, as: :Identifiable
end
