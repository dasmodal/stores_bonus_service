# frozen_string_literal: true

FactoryBot.define do
  factory :shop do
    name { "Rails Shop #{rand(99)}" }
  end
end
