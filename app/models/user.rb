class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  
  enum status: { active: 1, inactive: 0}
end
