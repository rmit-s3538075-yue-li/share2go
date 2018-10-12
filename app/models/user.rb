class User < ActiveRecord::Base
  attr_accessor :confirmation_token, :reset_token
  before_save   :downcase_email
  before_create :confirmation_token
  has_secure_password

  has_many :conversations, :foreign_key => :sender_id
  has_many :bookings
  has_many :cars, through: :bookings
  has_many :ratings
  
  
  validates :email, presence:true, format:{with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/},uniqueness: { case_sensitive: false }
  validates :license_no, presence:true, format:{with: /(0[1-9][0-9]*)/}, uniqueness: true
  
  validates :password, presence:true, length:{minimum: 10}, :allow_blank => true
  validates :mobile, presence:true, format:{with: /04\d{8}/}
  
   
   def name 
       self.first_name + " " + self.last_name
   end
   
   def booked_car
       bookings.find_all{|b| b[:status] == "Booked"}[0] 
   end
   
   def picked_up_car
       bookings.find_all{|b| b[:status] == "Picked Up"}[0] 
   end
   
   def returning_car
      bookings.find_all{|b| b[:status] == "Returning"}[0] 
   end
   
   def current_booking
        if booked_car
            booked_car
        elsif picked_up_car
            picked_up_car
        elsif returning_car
            returning_car
        end
   end
   
   def send_password_reset_email
    generate_token(:password_reset_token)
    self.password_reset_send_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_now
    # format.html { redirect_to @user, notice: ' Please confirm your email.'  + edit_password_reset_url(@user.password_reset_token) }
    #     format.json { render :show, status: :created, location: @user }
   end
   
   
    # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.generate_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
  end
  
   def email_activate
      self.email_confirmed = true
      self.confirm_token = nil
      save!(:validate => false)
   end
   
   private
   
       # Converts email to all lower-case.
       def downcase_email
          self.email = email.downcase
       end
        
       def confirmation_token 
          if self.confirm_token.blank?
              self.confirm_token = SecureRandom.urlsafe_base64.to_s
          end
       end
       
    def self.search(id)
      if id
        where('id LIKE ?', "%#{id}%")
      else
        all
      end
    end
end