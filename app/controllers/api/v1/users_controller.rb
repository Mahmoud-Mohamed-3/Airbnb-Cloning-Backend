class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :get_current_user, :get_user_wishlisted_properties, :show_user_info ]
  def get_current_user
    if current_user
      render json: current_user
    else
      render json: { message: "User not found" }, status: :not_found
    end
  end
  def show_user_info
    user = User.find(params[:id])
    render json: user, serializer: UserSerializer
  end
  def get_owner_of_property
    property = Property.find(params[:id])
    owner = property.user
    render json: owner, serializer: UserSerializer
  end
  def get_user_wishlisted_properties
    user = User.find(params[:id])
    properties = user.whishlisted_properties
    render json: properties, each_serializer: PropertySerializer, action: :index
  end
end
