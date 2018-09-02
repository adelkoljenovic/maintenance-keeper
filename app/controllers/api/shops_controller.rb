class Api::ShopsController < ApplicationController

  def index
    @shops = Shop.all
    render "index.json.jbuilder"
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

