class Api::ShopsController < ApplicationController

  def create
    @shop = Shop.new(
      name: params[:shop_name],
      address: params[:address],
      contact_name: params[:contact_name],
      telephone_number: params[:telephone_number],
      notes: params[:special_notes],
      user_id: current_user.id
    )
    if @shop.save!
      render "show.json.jbuilder"
    else
      render json: {errors: @shop.errors.full_messages}, status: :unprocessable_entity
    end
  end
end

#  create_table "shops", force: :cascade do |t|
#    t.string "name"
#    t.string "address"
#    t.string "contact_name"
#    t.integer "telephone_number"
#    t.string "notes"
#    t.datetime "created_at", null: false
#    t.datetime "updated_at", null: false
#    t.integer "user_id"