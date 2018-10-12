class Car < ActiveRecord::Base
    has_many :bookings
    has_many :users, through: :bookings
    belongs_to :locations
    mount_uploader :image, ImageUploader
    has_many :ratings
    
    
     
    validates_presence_of :image, :make, :year, :model, :body_type, :number_plate, :condition, :price, :status, :location_id
    
    def deposit 
       self.price*7 
    end
    
    def name 
       self.year.to_s + " " + self.make.strip + " " + self.model.strip 
    end
    
   def rating
      if (!(self.ratings.pluck(:rating).inject{ |sum, el| sum + el }.to_f / self.ratings.size).nan?)
        (self.ratings.pluck(:rating).inject{ |sum, el| sum + el }.to_f / self.ratings.size).round
      else
          0
      end
   end
    
    # def self.search(body_type)
    #   if body_type
    #     where('body_type LIKE ?', "%#{body_type}%")
    #   else
    #     all
    #   end
    # end

end
