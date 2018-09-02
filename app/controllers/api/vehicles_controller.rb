class Api::VehiclesController < ApplicationController
  def search
    response = Unirest.get("https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVinValues/#{params[:vinkey]}?format=json")
    @vehicle = response.body
    render "search.json.jbuilder"
  end

  def index
    if current_user
      @vehicles = current_user.vehicles
      render "index.json.jbuilder"
    else
      render json: {message: "You are not authorized to view this page, please sign in or create an account"}
    end
  end

  def create
    @vehicle = Vehicle.new(
      vin: params[:vin],
      year: params[:year],
      make: params[:make],
      model: params[:model],
      user_id: current_user.id
      ) 
    @vehicle.save!
    render "show.json.jbuilder" 
  end

  def destroy
    vehicle_id = params[:id]
    @vehicle = Vehicle.find_by(id: vehicle_id)
    @vehicle.destroy
    render json: {message: "You deleted one of your saved vehicles"}
  end    
end
