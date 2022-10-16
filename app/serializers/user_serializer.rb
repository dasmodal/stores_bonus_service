class UserSerializer < ActiveModel::Serializer
  type :users

  attributes :id, :email, :negative_balance

  has_many :cards do
    include_data false
    link(:related) { "#{api_v1_cards_path}?filter[user_id]=#{object.id}" }
  end

  has_many :shops do
    include_data false
    link(:related) { "#{api_v1_shops_path}?filter[user_id]=#{object.id}" }
  end
end
