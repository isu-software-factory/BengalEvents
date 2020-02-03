class Teacher < ApplicationRecord
  belongs_to :role
  validates :school_name, presence:true
end
