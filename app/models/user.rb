# frozen_string_literal: true

class User < ApplicationRecord
  has_many :cards
  has_many :shops, through: :cards

  validates :email, presence: true
  validates :email, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
  validates :email, uniqueness: true
end
