class Api::V1::PropertiesController < ApplicationController
  before_action :authenticate_user!, only: [ :create ]

  def index
    properties = Property.includes(:reviews)

    if current_user
      properties = properties.where.not(user_id: current_user.id)
    end


    render json: properties, each_serializer: PropertySerializer ,action: :index
  end
  def show
    property = Property.find(params[:id])
    render json: property, serializer: PropertySerializer , action: :show
  end
  def create
    unless current_user
      return render json: { error: "You must be logged in to create a property" }, status: :unauthorized
    end

    @property = current_user.properties.build(property_params)
    @property.owner = current_user.first_name

    if @property.save
      render json: @property, serializer: PropertySerializer, status: :created
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  private

  def property_params
    params.require(:property).permit(:city, :country, :price, :start_date, :end_date, :description, :type_of_property, :place, :max_guests, :beds, :bedrooms, :baths, images: [])
  end
end
