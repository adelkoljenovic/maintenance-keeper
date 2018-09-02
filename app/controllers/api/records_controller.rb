class Api::RecordsController < ApplicationController
  def index
    if current_user
      @records = current_user.records
      render "index.json.jbuilder"
    else
      render json: {message: "You are not authorized to view this page, please sign in or create an account"}
    end
  end

  def create
    @record = Record.new(
      vehicle_id: params[:vehicle_id],
      maintenance_type: params[:maintenance_type],
      current_mileage: params[:odometer],
      date: params[:date],
      shop_id: params[:shop_id],
      user_id: current_user.id
    )
    if @record.save!
      render "show.json.jbuilder"
    else
      render json: {errors: @record.errors.full_messages}, status: :unprocessable_entity
    end
  end
end


# create_table "records", force: :cascade do |t|
#    t.string "vehicle_id"
#    t.string "maintenance_type"
#    t.string "current_mileage"
#    t.integer "date"
#    t.string "shop_id"
#    t.datetime "created_at", null: false
#    t.datetime "updated_at", null: false
#    t.integer "user_id"
#  end




