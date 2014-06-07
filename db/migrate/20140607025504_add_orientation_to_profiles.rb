class AddOrientationToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :orientation, :string
  end
end
