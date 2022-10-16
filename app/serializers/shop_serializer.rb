class ShopSerializer < ActiveModel::Serializer
  type :shops

  attributes :id, :name

  has_many :cards do
    include_data false
    link(:related) { "#{api_v1_cards_path}?filter[shop_id]=#{object.id}" }
  end

  has_many :users do
    include_data false
    link(:related) { "#{api_v1_users_path}?filter[shop_id]=#{object.id}" }
  end
end
