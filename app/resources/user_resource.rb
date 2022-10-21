class UserResource < ApplicationResource
  attribute :email, :string
  attribute :negative_balance, :boolean

  has_many :cards
  has_many :shops, through: :cards
end
