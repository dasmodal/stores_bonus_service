class ShopSerializer < ActiveModel::Serializer
  type :shops

  attributes :id, :name
end
