class AddStatusToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :single, :boolean
    add_column :profiles, :tagline, :string
  end
end
