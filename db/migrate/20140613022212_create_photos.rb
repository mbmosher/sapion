class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :profile_id
      t.string :avatar
      t.string :caption

      t.timestamps
    end
  end
end
