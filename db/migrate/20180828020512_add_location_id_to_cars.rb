class AddLocationIdToCars < ActiveRecord::Migration
  def change
    add_column :cars, :location_id, :integer
  end
end
