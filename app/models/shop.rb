class Shop < ApplicationRecord
  has_many :card

  validates :name, presence: true
  validates :name, uniqueness: true
end
