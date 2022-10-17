# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :card
  has_many :users, through: :card

  validates :name, presence: true
  validates :name, uniqueness: true
end
