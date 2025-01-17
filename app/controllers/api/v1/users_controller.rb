class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  def get_current_user
    if current_user
      render json: current_user
    else
      render json: { message: "User not found" }, status: :not_found
    end
  end
end
