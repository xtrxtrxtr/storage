# frozen_string_literal: true

require 'rails_helper'

FactoryBot.factories.map(&:name).each do |factory_name|
  RSpec.describe "The #{factory_name} factory" do
    subject { build(factory_name) }

    it { is_expected.to be_valid }
  end
end
