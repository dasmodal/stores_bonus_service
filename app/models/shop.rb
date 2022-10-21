# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :cards
  has_many :users, through: :cards

  validates :name, presence: true
  validates :name, uniqueness: true
end
