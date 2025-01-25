class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  def get_current_user
    if current_user
      render json: current_user
    else
      render json: { message: "User not found" }, status: :not_found
    end
  end
  def get_user_wishlisted_properties
    user = User.find(params[:id])
    properties = user.whishlisted_properties
    render json: properties, each_serializer: PropertySerializer, action: :index
  end
end
