class UsersController < ApplicationController
  before_action :authorize, only: [:show]

  def create
    user=User.create!(user_params)
    if user.valid?
      session[:user_id]=user.id
      render json: user,status: :created
    else
       return render json:{error: user.errors.full_message},status: :unprocessable_entity
    end
  end

  def show
    render json: @current_user
  end

  private 

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end

  def authorize
    return render json: {error: "Not authorized"},status: :unauthorized unless session.include? :user_id
  end
end
