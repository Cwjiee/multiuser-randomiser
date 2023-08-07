class AddResultMessageToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :result_message, :boolean, default: false
    end
end
