class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  after_destroy :reset_pk_sequence
  after_commit :format_message, on: :update

  private 
    def reset_pk_sequence
      User.connection.execute("DELETE FROM sqlite_sequence WHERE name = 'users';")
    end

  def format_message
    confirm = check_status

    if confirm
      msg = find_duplicate
      finalResult = msg[rand(msg.length)]
      ActionCable.server.broadcast('MessageChannel', { content: msg, system_message: true})
      ActionCable.server.broadcast('MessageChannel', { content: finalResult, result_message: true})
    end
  end

  def check_status
    sent_message = 0
    User.all.each do |user|
      sent_message += 1 if user.sent
    end
    sent_message == User.all.count
  end

  def find_duplicate
    element_count = Hash.new(0)
    dup = []
    User.all.each do |user|
      user.status = 0
      message = Message.find_by(user_id: user.id)
      messages = message.content.split(', ')
      messages.each do |cont|
        element_count[cont] += 1
        dup << cont if element_count[cont] > 1
      end
    end
    dup
  end
end
