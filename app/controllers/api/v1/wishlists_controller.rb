class Api::V1::WishlistsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy, :index ]

  # GET /api/v1/wishlists
  def index
    wishlists = current_user.wishlists
    render json: wishlists, each_serializer: WishlistSerializer
  end

  # POST /api/v1/wishlists
  def create
    @wishlist = current_user.wishlists.build(wishlist_params)
    if @wishlist.save
      render json: @wishlist, serializer: WishlistSerializer, status: :created
    else
      render json: { errors: @wishlist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/wishlists
  def destroy
    @wishlist = current_user.wishlists.find_by!(property_id: params[:wishlist][:property_id])
    @wishlist.destroy
    render json: { message: "Wishlist item deleted" }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Wishlist item not found" }, status: :not_found
  end

  private


  def wishlist_params
    params.require(:wishlist).permit(:property_id)
  end
end
