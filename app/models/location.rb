class Location < ActiveRecord::Base
    has_many :cars
    
    validates_presence_of :number, :street, :suburb, :state, :postcode, :longitude, :latitude 
    
    
    def address
       self.number.to_s + " " + self.street + ", " + self.suburb + ", " + self.postcode.to_s + ", " + self.state 
    end
end
