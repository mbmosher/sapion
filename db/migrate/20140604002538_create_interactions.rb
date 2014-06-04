class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.integer :user_id
      t.integer :conversation_id

      t.timestamps
    end
  end
end
