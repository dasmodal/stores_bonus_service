# frozen_string_literal: true

class User < ApplicationRecord
  has_many :card
  has_many :shops, through: :card

  validates :email, presence: true
  validates :email, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
  validates :email, uniqueness: true
end
