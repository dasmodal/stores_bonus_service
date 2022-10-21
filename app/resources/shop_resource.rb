class ShopResource < ApplicationResource
  attribute :name, :string

  has_many :cards
  has_many :users, through: :cards
end
