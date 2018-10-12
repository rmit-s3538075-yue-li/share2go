class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy, :car_detail]

  before_action :admin_authorize, only: [:new, :edit, :create, :update, :destroy, :list]
  
  

  # GET /cars
  # GET /cars.json
  def index

    @cars = Car.all
    
    @cars = @cars.select{|car| car.status = 'Available'}
    
    if params[:body_type]
      @cars = @cars.select{|car| params[:body_type].include? car.body_type }
    end
    
    if params[:condition]
      @cars = @cars.select{|car| params[:condition].include? car.condition }
    end
    
    if params[:price] 
      @temp = Array.new
      
      params[:price].each do |price|
        case price
        when '0~50'
          @temp += @cars.select {|car| car.price <= 50 && car.price > 0}
        when '50~100'
          @temp += @cars.select {|car| car.price <= 100 && car.price > 50}
        when '100~150'
        @temp += @cars.select {|car| car.price <= 150 && car.price > 100}
        when '150~200'
        @temp += @cars.select {|car| car.price <= 200 && car.price > 150}
        when '200~∞'
        @temp += @cars.select {|car| car.price > 200}
        else
          
        end
      end
    end
    @cars = @temp if params[:price]
  end

  # GET /cars/1 
  # GET /cars/1.json
  def show
  end
  
  
  # GET /cars/new
  def new
    @car = Car.new
    @locations = Location.where(status: 'Available')
  end

  # GET /cars/1/edit
  def edit
    @locations = Location.where(status: 'Available')
    @locations << Location.find(@car.location_id) if @car.location_id
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      old_location = Location.find(@car.location_id)
      if @car.update(car_params)
        new_location = Location.find(@car.location_id)
        
        old_location.status = "Available"
        old_location.save
        
        new_location.status = "Unavailable"
        new_location.save
        
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def list
    @cars = Car.all
    if (params[:number_plate])
      @cars = @cars.select{|car| car.number_plate == params[:number_plate].strip}
    else
      @cars= Car.all
    end
  end
  
  def car_detail
    @bookings = @car.bookings
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:image, :make, :year, :model, :body_type, :number_plate, :condition, :price, :location_id, :status)
    end
end
