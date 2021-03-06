class Api::ShopsController < ApplicationController
  def index
    if current_user
      @shops = current_user.shops
      render "index.json.jbuilder"
    else
      render json: {message: "You are not authorized to view this page, please sign in or create an account"}
    end
  end

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

