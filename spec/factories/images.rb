# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    component
    image { File.open(Rails.root.join('spec/fixtures/images/1x1.svg').to_s, 'r') }
  end
end
