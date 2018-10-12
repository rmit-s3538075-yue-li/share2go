class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :booking_id
      t.integer :car_id
      t.integer :rating
      t.datetime :time

      t.timestamps null: false
    end
  end
end
