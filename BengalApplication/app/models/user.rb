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
  has_many :assignments
  has_many :groupings
  has_many :registrations
  has_many :sessions, through: :registrations
  has_many :teams, through: :groupings
  has_many :roles, through: :assignments
  has_one :teacher
  belongs_to :teacher, optional: true

  attr_accessor :login
  validates :email, :user_name, presence: true, uniqueness: {case_sensitive: false}
  validates :first_name, :last_name, presence: true
  validates :encrypted_password,presence:true
  validates_format_of :user_name, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  validate :validate_username

  def validate_username
    if User.where(email: user_name).exists?
      errors.add(:user_name, :invalid)
    end
  end

  def extra_properties?
    if (self.roles.first.role_name == "Teacher")
      Teacher.find_by(user_id: self.id)
    else
      false
    end
  end

  def login
    @login || self.user_name || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(user_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:user_name) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

end
