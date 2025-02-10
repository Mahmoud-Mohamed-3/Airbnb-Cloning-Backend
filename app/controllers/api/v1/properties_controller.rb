class Api::V1::PropertiesController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy, :update ]

  def index
    properties = Property.includes(:reviews)
    if current_user
      properties = properties.where.not(user_id: current_user.id)
    end
    properties=properties.reject { |property| property.end_date < Date.today }
    render json: properties, each_serializer: PropertySerializer, action: :index
  end
  def show
    property = Property.find(params[:id])
    render json: property, serializer: PropertySerializer, action: :show
  end
  def create
    unless current_user
      return render json: { error: "You must be logged in to create a property" }, status: :unauthorized
    end
    @property = current_user.properties.build(property_params)
    @property.owner = current_user.first_name

    if @property.save
      @other_users = User.where.not(id: current_user.id)
      @other_users.each do |user|
        @sent_user= user.to_json
        @target_property = @property.to_json
        SendPropertiesUpdatesToUsersJob.perform_async(@sent_user, @target_property)
      end
      render json: @property, serializer: PropertySerializer, status: :created
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end
  def destroy
    property = Property.find(params[:id])
    prop = property.to_json
    RemovePropertyJob.perform_async(prop)
  end

  def update
    @property = Property.find(params[:id])

    if @property.update(property_params)
      if params[:property][:existing_images].present?
        existing_image_ids = params[:property][:existing_images]
        @property.images.where(id: existing_image_ids).each do |image|
          image.purge_later unless @property.images.include?(image)
        end
      end
      if params[:property][:images].present?
        params[:property][:images].each do |image|
          @property.images.attach(image)
        end
      end

      render json: @property, status: :ok
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end
  private

  def property_params
    params.require(:property).permit(:city, :country, :price, :start_date, :end_date, :description, :type_of_property, :place, :max_guests, :beds, :bedrooms, :baths, images: [])
  end
end
