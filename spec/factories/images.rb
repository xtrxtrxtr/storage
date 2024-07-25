# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    component
    image { File.open("#{Rails.root}/spec/fixtures/images/1x1.svg", 'r') }
  end
end
