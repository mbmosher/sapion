class RemoveFieldsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :zipcode, :integer
    remove_column :users, :height, :integer
    remove_column :users, :weight, :integer
    remove_column :users, :kids, :boolean
    remove_column :users, :pets, :boolean
    remove_column :users, :birthday, :datetime
    remove_column :users, :rank, :integer
    remove_column :users, :subscribed, :boolean
  end
end
