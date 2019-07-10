class Teacher < ApplicationRecord
  has_one :user, as: :Identifiable
end
