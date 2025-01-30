class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :status, :property, :user, :start_date, :end_date, :total_price, :number_of_days

  def property
    PropertySerializer.new(object.property, { scope: scope, root: false })
  end

  def user
    UserSerializer.new(object.user, { scope: scope, root: false })
  end

  def number_of_days
    object.number_of_days
  end
end
