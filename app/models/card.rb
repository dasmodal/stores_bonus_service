class Card < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  validates :user, uniqueness: { scope: :shop }

  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :by_shop, ->(shop_id) { where(shop_id: shop_id) }
end
