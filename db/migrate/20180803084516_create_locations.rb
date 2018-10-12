class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :number
      t.string :street
      t.string :suburb
      t.string :state
      t.integer :postcode
      t.integer :longitude
      t.integer :latitude

      t.timestamps null: false
    end
  end
end
