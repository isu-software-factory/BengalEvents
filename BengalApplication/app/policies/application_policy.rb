class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def get_role
    user.roles.first.role_name
  end

 
end
