class Booking < ActiveRecord::Base
    belongs_to :car
    belongs_to :user
    
    validates_presence_of :car_id , :user_id, :book_time, :pickup_location_id, :status
    
    # validates_presence_of :return_time, :return_location (if status is DONE)
    
    def fee
        if self.pickup_time && self.return_time && Car.exists?(id: car_id)
            Car.find(self.car_id).price * ((self.return_time - self.pickup_time)/1.day).ceil 
        end
    end
    !
    def fee_so_far
        Car.find(self.car_id).price * ((Time.now - self.pickup_time)/1.day).ceil if self.pickup_time && Car.exists?(id: car_id)
    end
end
