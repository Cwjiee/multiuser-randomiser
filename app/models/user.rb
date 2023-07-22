class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  after_destroy :reset_pk_sequence

  enum status: { active: 1, inactive: 0}

  private 
    def reset_pk_sequence
      User.connection.execute("DELETE FROM sqlite_sequence WHERE name = 'users';")
    end
end
