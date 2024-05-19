# frozen_string_literal: true

FactoryBot.define do
  factory :component do
    sequence(:name) { |n| "component_#{n}" }
  end
end
