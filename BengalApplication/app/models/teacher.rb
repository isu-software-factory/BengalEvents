class Teacher < ApplicationRecord
  has_one :user, as: :Identifiable

  validates :school, presence: true
  validates :chaperone_count, presence: true
  validates :student_count, presence: true

end
