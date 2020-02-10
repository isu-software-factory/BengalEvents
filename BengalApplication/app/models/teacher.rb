class Teacher < ApplicationRecord
  validates :school_name, presence:true
  validates :chaperone_count, presence: true
  belongs_to :user
  has_many :users
end
