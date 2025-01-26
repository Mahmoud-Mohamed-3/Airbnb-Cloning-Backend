class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :status, :property, :user

  def property
    PropertySerializer.new(object.property, { scope: scope, root: false })
  end

  def user
    UserSerializer.new(object.user, { scope: scope, root: false })
  end
end
