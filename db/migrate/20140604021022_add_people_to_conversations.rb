class AddPeopleToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :initiator, :integer
    add_column :conversations, :mark, :integer
  end
end
