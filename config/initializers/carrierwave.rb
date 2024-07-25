# frozen_string_literal: true

if Rails.env.test?
  CarrierWave.configure do |config|
    config.root = Rails.root.join('spec/support')
    config.storage = :file
    config.enable_processing = false
  end
end
