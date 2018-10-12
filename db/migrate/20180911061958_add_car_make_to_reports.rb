class AddCarMakeToReports < ActiveRecord::Migration
  def change
    add_column :reports, :car_make, :string
  end
end
