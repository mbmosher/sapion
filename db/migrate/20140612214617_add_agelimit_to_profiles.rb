class AddAgelimitToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :agelimit, :integer
  end
end
