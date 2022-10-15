class CardSerializer < ActiveModel::Serializer
  type :cards

  attributes :id, :bonuses
  
  has_one :user do
    include_data false
    link(:related) { api_v1_user_path(id: object.user_id) }
  end

  has_one :shop do
    include_data false
    link(:related) { api_v1_shop_path(id: object.shop_id) }
  end
end
