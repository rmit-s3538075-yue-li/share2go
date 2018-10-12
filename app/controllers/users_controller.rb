class UsersController < ApplicationController
  # attr_accessible :email, :password, :password_confirmation
  before_action :set_user, only: [:show, :edit, :update, :destroy, :dashboard, :pick_up_car, :choose_return_location, :returned_car, :history]
  before_action :authorize, only: [:edit, :dashboard, :pick_up_car, :choose_return_location, :returned_car, :profile, :history]
  before_action :admin_authorize, only: [:index, :destroy]

  # GET /users
  # GET /users.json
  def index
    if (params[:id])
    @users = User.search(params[:id].strip)
    else
    @users= User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @bookings = @user.bookings
  end

  # GET /users/new
  def new
    @user = User.new
    # @user.credit = 0
    
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        UserMailer.registration_confirmation(@user).deliver_now
        format.html { redirect_to @user, notice: 'User was successfully created. Please confirm your email.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def confirm_email 
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      redirect_to root_url, notice: "Welcome! Your account has been activated."
    else
      redirect_to root_url, notice: "Error. User does not exist."
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:password].blank?
    params.delete(:password)
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def dashboard
    # redirect_to "/" if params[:id] != current_user.id
    @user = User.find(params[:id])
    @current_booking = @user
  end
  
  def history
    @bookings = @user.bookings
  end
  
  def profile
    @user = current_user
  end
  
  def pick_up_car
    booking = @user.booked_car
    booking.status = "Picked Up"
    booking.pickup_time = Time.current
    booking.save
    
    car = Car.find(booking.car_id)
    car.location_id = nil
    car.save
    
    location = Location.find(booking.pickup_location_id)
    location.status = "Available"
    location.save
    
    redirect_to "/users/"+booking.user_id.to_s+"/dashboard"
  end
  
  def choose_return_location
      @locations = Location.where(status: 'Available')
  end
  
  def set_return_location
    booking= current_user.picked_up_car
    booking.status = "Returning"
    booking.return_location_id = params[:location_id]
    booking.save
    
    location = Location.find(params[:location_id])
    location.status = "Unavailable"
    location.save 
    
    redirect_to "/users/"+booking.user_id.to_s+"/dashboard"
  end
  
  def returned_car
    booking = @user.returning_car
    booking.status = "Finished"
    booking.return_time = Time.current
    booking.save
    
    car = Car.find(booking.car_id)
    car.location_id = booking.return_location_id
    car.status = "Available"
    car.save
    
    @user.update(credit: @user.credit - booking.fee)

    redirect_to "/users/"+booking.user_id.to_s+"/dashboard"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :license_no, :mobile, :email, :password, :password_confirmation, :credit)
    end
end 