# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Component do
  before do
    create(:component)
  end

  it_behaves_like 'has_uuid'

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_uniqueness_of(:name) }

    it 'allows lowercase letters, underscore, and digits for name' do
      entity = build(:component, name: 'a_1')
      expect(entity).to be_valid
    end

    it 'disallows anything but lowercase letters, underscore, and digits for name', :aggregate_failures do
      entity = build(:component, name: 'No-way!')
      expect(entity).not_to be_valid
      expect(entity.errors.messages).to have_key(:name)
    end
  end
end
