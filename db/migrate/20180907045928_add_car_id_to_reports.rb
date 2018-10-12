class AddCarIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :car_id, :integer
  end
end
