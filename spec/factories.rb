# frozen_string_literal: true

FactoryBot.define do
  factory :color do
    name { 'white' }
    code { '#fff' }
  end

  factory :palette do
    sequence(:name) { |n| "palette-#{n}" }
  end

  factory :palette_color do
    palette
    color
  end
end
