class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :get_current_user, :show_user_info, :update_user ]
  def get_current_user
    if current_user
      render json: current_user
    else
      render json: { message: "User not found" }, status: :not_found
    end
  end

  def show_user_info
    authenticate_user!
    if current_user.id != params[:id].to_i
      render json: { message: "You are not authorized to view this user" }, status: :unauthorized
      return
    end
    user = User.find(params[:id])
    render json: user, serializer: UserSerializer
  end

  def update_user
    authenticate_user!
    if current_user.id != params[:id].to_i
      render json: { message: "You are not authorized to update this user" }, status: :unauthorized
      return
    end
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, serializer: UserSerializer
    else
      render json: { message: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def get_owner_of_property
    property = Property.find(params[:id])
    owner = property.user
    first_name = owner.first_name
    profile_image_url = owner.profile_image.attached? ? Rails.application.routes.url_helpers.rails_blob_url(owner.profile_image) : nil
    render json: { first_name: first_name, profile_image_url: profile_image_url }
  end

  def get_user_wishlisted_properties
    user = User.find(params[:id])
    properties = user.whishlisted_properties
    render json: properties, each_serializer: PropertySerializer, action: :index
  end
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :profile_image)
  end
end
