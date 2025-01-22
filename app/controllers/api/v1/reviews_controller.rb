class Api::V1::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [ :create ]

  def index
    reviews = Review.all
    render json: reviews, each_serializer: ReviewSerializer
  end

  def create
    if current_user
      @review = current_user.reviews.build(review_params)
      @review.final_rating = (@review.cleanliness_rating + @review.accurancy_rating + @review.check_in_rating + @review.value_rating + @review.communication_rating + @review.location_rating) / 6
      if @review.save
        render json: @review
        # , serializer: ReviewSerializer, status: :created
      else
        render json: @review.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :cleanliness_rating, :accurancy_rating, :check_in_rating, :value_rating, :communication_rating, :location_rating, :property_id)
  end
end
