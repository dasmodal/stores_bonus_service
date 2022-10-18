# frozen_string_literal: true

class Card < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  validates :user, uniqueness: { scope: :shop }

  scope :by_user, ->(user_id) { where(user_id:) }
  scope :by_shop, ->(shop_id) { where(shop_id:) }
end
