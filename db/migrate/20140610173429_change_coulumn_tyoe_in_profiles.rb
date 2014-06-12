class ChangeCoulumnTyoeInProfiles < ActiveRecord::Migration
  def change
    change_column :profiles, :zipcode, :string
  end
end
