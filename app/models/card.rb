class Card < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  validates :user, uniqueness: { scope: :shop }
end
