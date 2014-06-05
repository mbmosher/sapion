class AddDistanceToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :distance, :integer
  end
end
