# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  meta_id                :integer
#  meta_type              :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :encrypted_password,presence:true
  has_many :assignments
  has_many :user
  has_many :groupings
  has_many :registrations
  has_many :sessions, through: :registrations
  has_many :teams, through: :groupings
  has_many :roles, through: :assignments
  has_many :teachers

  validates :email, presence: true
  validates :user_name, presence: true
  validates_uniqueness_of :email, :user_name
  validates :first_name, presence: true
  validates :last_name, presence: true


  def extra_properties?
    if (self.roles.first == "Teacher")
      self.roles.first.find(self.id)
    else
      false
    end

  end

end
