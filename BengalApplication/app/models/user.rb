class User < ApplicationRecord
  has_one :student
  has_one :teacher

  enum role: [:teacher, :student, :sponsor, :coordinator, :admin]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :teacher
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
