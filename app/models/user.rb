class User < ApplicationRecord
  has_many :card

  validates :email, presence: true
  validates :email, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
  validates :email, uniqueness: true
end
