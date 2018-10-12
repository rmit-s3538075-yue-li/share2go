class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :image
      t.string :make
      t.integer :year
      t.string :model
      t.string :body_type
      t.string :number_plate
      t.string :condition
      t.integer :price
      t.string :status

      t.timestamps null: false
    end
  end
end
