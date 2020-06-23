class Teacher < ApplicationRecord
  validates :school_name, presence:true
  validates :chaperone_count, presence: true
  has_many :users, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
