class ChangeLatitudeToFloatInLocations < ActiveRecord::Migration
  def change
    change_column :locations, :latitude, :float
  end
end
