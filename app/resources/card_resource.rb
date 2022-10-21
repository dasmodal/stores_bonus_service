class CardResource < ApplicationResource
  attribute :bonuses, :integer

  belongs_to :user
  belongs_to :shop
end
