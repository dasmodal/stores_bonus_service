class UserSerializer < ActiveModel::Serializer
  type :users

  attributes :id, :email, :negative_balance
end
