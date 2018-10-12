class Report < ActiveRecord::Base
    belongs_to :booking
    belongs_to :user
    
    validates_presence_of :booking_id , :user_id, :car_id, :content
end
