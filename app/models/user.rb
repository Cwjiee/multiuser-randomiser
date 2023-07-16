class User < ApplicationRecord
  has_many :messages, dependant: :destroy
end
