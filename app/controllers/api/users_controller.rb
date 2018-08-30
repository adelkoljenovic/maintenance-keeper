class Api::UsersController < ApplicationController
# def index
#   @users = User.all
#   render "index.json.jbuilder"
# end

  def create
    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if @user.save
      render "show.json.jbuilder"
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end
end


#  create_table "users", force: :cascade do |t|
#    t.string "first_name"
#    t.string "last_name"
#    t.string "email"
#    t.string "password_digest"
#    t.datetime "created_at", null: false
#    t.datetime "updated_at", null: false
#  end