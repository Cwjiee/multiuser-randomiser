class AddSystemMessageToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :system_message, :boolean, default: false
  end
end
