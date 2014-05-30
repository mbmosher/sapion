class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :zipcode, :integer
    add_column :users, :bio, :text
    add_column :users, :kids, :boolean
    add_column :users, :pets, :boolean
    add_column :users, :birthday, :datetime
    add_column :users, :rank, :integer
    add_column :users, :subscribed, :boolean
    add_column :users, :weight, :integer
    add_column :users, :height, :integer
  end
end
