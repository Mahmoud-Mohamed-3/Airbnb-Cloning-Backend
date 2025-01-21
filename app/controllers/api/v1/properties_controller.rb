class Api::V1::PropertiesController < ApplicationController
  before_action :authenticate_user!

  def index
    properties = Property.all
    render json: properties, each_serializer: PropertySerializer
  end

  def create
    if current_user
      @property = current_user.properties.build(property_params)
      @property.owner = current_user.first_name
        if @property.save
          render json: @property, serializer: PropertySerializer, status: :created
        else
          render json: @property.errors, status: :unprocessable_entity
        end
    end
  end

  private

  def property_params
    params.require(:property).permit(:city, :country, :price, :duration, :description, images: [])
  end
end