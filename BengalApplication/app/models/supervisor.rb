class Supervisor < ApplicationRecord
  belongs_to :director, polymorphic: true

end
