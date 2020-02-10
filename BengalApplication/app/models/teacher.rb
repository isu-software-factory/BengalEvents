class Teacher < ApplicationRecord
  validates :school_name, presence:true
  validates :chaperone_count, presence: true
  has_many :users
  belongs_to :user
end
