class AdminsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :admin_authorize
  

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def dashboard
    @this_week = Date.today.strftime("%W").to_i
    @weeks = Hash.new
    8.times.each do |i|
      @weeks[@this_week-7+i] = 0
    end
      
    @months = Hash.new
    @months[1] = 0;
    @months[2] = 0;
    @months[3] = 0;
    @months[4] = 0;
    @months[5] = 0;
    @months[6] = 0;
    @months[7] = 0;
    @months[8] = 0;
    @months[9] = 0;
    @months[10] = 0;
    @months[11] = 0;
    @months[12] = 0;
    
    @quarters = Hash.new
    @quarters[1] = 0;
    @quarters[2] = 0;
    @quarters[3] = 0;
    @quarters[4] = 0;
    
    @this_year = Date.today.strftime("%Y").to_i
    @years = Hash.new
    7.times.each do |i|
      @years[@this_year-6+i] = 0
    end

    @bookings = Booking.where(status: "Finished")
    @bookings.each do |booking|
      
      week = booking.book_time.strftime("%W")
      month = booking.book_time.strftime("%m")
      quarter = (month.to_i-1)/3 + 1
      year = booking.book_time.strftime("%Y")

      fee = booking.fee

      if fee 
        if year == Date.today.strftime("%Y")
          if @weeks.keys.include?(week.to_i)
            @weeks[week.to_i] += fee
          end
          @months[month.to_i] += fee
          @quarters[quarter.to_i] += fee
        end
        
        if @years.keys.include?(year.to_i)
          @years[year.to_i] += fee
        end
      end
    end
    
    @final_week_data = "" 
    @weeks.values.each do |week|
      @final_week_data = @final_week_data + week.to_s + ","
    end
    
    @final_year_label = ""
    @years.keys.each do |key|
      @final_year_label = @final_year_label + key.to_s + ","
    end
    
    @final_year_data = ""
    @years.values.each do |year|
      @final_year_data = @final_year_data + year.to_s + ","
    end
  end
  
  def cancel_booking
    @booking = Booking.find(params["id"])
  end
  
  def update_cancel_booking
    booking = params["booking_id"]
    car = Car.find(booking.car_id) 
    pickup_location = Location.find(booking.pickup_location_id)
    return_location = Location.find(booking.return_location_id)
    
    car.status = params["car_status"] if params["car_status"]
    # car location
    car.save
    
    pickup_location.status = params["pickup_location_status"] if params["pickup_location_status"]
    pickup_location.save
    
    return_location.status = params["return_location_status"] if params["return_location_status"]
    return_location.save
    redirect_to "/"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:username, :password, :password_confirmation)
    end
end
