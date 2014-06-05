class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :gender
      t.integer :minage
      t.integer :maxage
      t.integer :minweight
      t.integer :maxweight
      t.integer :minheight
      t.integer :maxheight
      t.boolean :pets
      t.boolean :kids

      t.timestamps
    end
  end
end
