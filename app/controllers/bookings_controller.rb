class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :pick_up_car]
  before_action :authorize, only: [:new]
  before_action :admin_authorize, only: [:edit, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
    
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    if @current_user.booked_car || @current_user.picked_up_car || @current_user.returning_car
      redirect_to "/", notice: "You have booked a car already. Go to your dashboard to see the booking"
    end
    
    @booking = Booking.new
    @booking.car_id = params[:car]
    @booking.user_id = @current_user.id
    @booking.pickup_location_id = Car.find(params[:car]).location_id
    @booking.book_time = Time.current
    @booking.status = "Booked"
    
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    
    car = @booking.car
    
    if !current_user.credit || current_user.credit < car.deposit 
      redirect_to root_path, notice: "Not Enough Credit"
    else
    
      respond_to do |format|
        if @booking.save
          car.status = "Booked"
          car.save
          format.html { redirect_to @booking, notice: 'Booking was successfully created.  Please go to Dashboard to see the booking.' }
          format.json { render :show, status: :created, location: @booking }
        else
          format.html { render :new }
          format.json { render json: @booking.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.  Please go to Dashboard to see the booking.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:car_id, :user_id, :book_time, :pickup_time, :return_time, :pickup_location_id, :return_location_id, :status)
    end
end
