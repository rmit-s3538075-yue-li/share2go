class ChangeLongitudeToFloatInLocations < ActiveRecord::Migration
  def change
        change_column :locations, :longitude, :float
  end
end
