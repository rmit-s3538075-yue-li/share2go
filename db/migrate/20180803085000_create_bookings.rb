class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :car_id
      t.integer :user_id
      t.datetime :pickup_time
      t.datetime :return_time
      t.integer :pickup_location_id
      t.integer :return_location_id
      t.string :status

      t.timestamps null: false
    end
  end
end
