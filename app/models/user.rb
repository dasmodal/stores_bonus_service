class User < ApplicationRecord
  validates :email, presence: true
  validates :email, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
  validates :email, uniqueness: true
end
