class Api::VehiclesController < ApplicationController
  def index
    # @vehicle = Unirest.get(
    #   "https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVinValues/#{params[:vin]}?format=json"
    # ).body
    # p params
    response = Unirest.get("https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVinValues/#{params[:vinkey]}?format=json")
    @vehicle = response.body
    p response.body
    p params[:vin]

    render "index.json.jbuilder"
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
end

# #{params[:vin]}

#  create_table "vehicles", force: :cascade do |t|
#    t.string "vin"
#    t.integer "year"
#    t.string "make"
#    t.string "model"
#    t.string "nickname"
#    t.datetime "created_at", null: false
#    t.datetime "updated_at", null: false
#    t.integer "user_id"
#  end

# #{params[:vin]}

# https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVinValues/1FADP3K20GL348392?format=json
# 1FADP3K20GL348392