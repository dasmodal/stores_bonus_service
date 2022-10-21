class ShopResource < ApplicationResource
  attribute :name, :string

  has_many :cards
  has_many :users, through: :cards

  filter :user_id, :integer do
    eq do |scope, value|
      scope.joins(:cards).where('cards.user_id': value)
    end
  end

  filter :card_id, :integer do
    eq do |scope, value|
      scope.joins(:cards).where('cards.id': value)
    end
  end
end
