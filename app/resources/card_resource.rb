class CardResource < ApplicationResource
  attribute :bonuses, :integer

  belongs_to :user
  belongs_to :shop

  filter :user_id, :integer do
    eq do |scope, value|
      scope.where(user_id: value)
    end
  end

  filter :shop_id, :integer do
    eq do |scope, value|
      scope.where(shop_id: value)
    end
  end
end
