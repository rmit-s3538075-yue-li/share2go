require 'test_helper'

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save the car without make" do
    car=Car.new
    assert_not car.save
  end
end
