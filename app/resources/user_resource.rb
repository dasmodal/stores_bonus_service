class UserResource < ApplicationResource
  attribute :email, :string
  attribute :negative_balance, :boolean

  has_many :cards
  has_many :shops, through: :cards

  filter :shop_id, :integer do
    eq do |scope, value|
      scope.joins(:cards).where('cards.shop_id': value)
    end
  end

  filter :card_id, :integer do
    eq do |scope, value|
      scope.joins(:cards).where('cards.id': value)
    end
  end
end
