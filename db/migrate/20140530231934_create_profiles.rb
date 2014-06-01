class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.integer :zipcode
      t.integer :height
      t.integer :weight
      t.text :bio
      t.boolean :kids
      t.boolean :pets
      t.datetime :birthday
      t.integer :rank
      t.boolean :subscribed

      t.timestamps
    end
  end
end
