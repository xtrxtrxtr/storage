# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image do
  before do
    create(:image)
  end

  it_behaves_like 'has_uuid'

  describe 'validation' do
    it { is_expected.to belong_to(:component) }
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_length_of(:caption).is_at_least(1).is_at_most(255).allow_blank }
    it { is_expected.to validate_length_of(:checksum).is_at_least(1).is_at_most(128).allow_blank }
    it { is_expected.to validate_length_of(:image_alt_text).is_at_least(1).is_at_most(255).allow_blank }
    it { is_expected.to validate_length_of(:source_name).is_at_least(1).is_at_most(255).allow_blank }
  end

  describe 'validating source link' do
    it { is_expected.to validate_length_of(:source_link).is_at_least(1).is_at_most(255).allow_blank }

    it 'passes with valid URLs' do
      entity = build(:image, source_link: 'https://example.com')
      expect(entity).to be_valid
    end

    it 'fails with not URLs', :aggregate_failures do
      entity = build(:image, source_link: 'javascript:alert(1)')
      expect(entity).not_to be_valid
      expect(entity.errors.messages).to have_key(:source_link)
    end
  end
end
