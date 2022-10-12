class CardSerializer < ActiveModel::Serializer
  type :cards

  attributes :id, :bonuses
end
