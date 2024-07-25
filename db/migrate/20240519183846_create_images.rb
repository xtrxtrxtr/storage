# frozen_string_literal: true

# Create table for Image model
class CreateImages < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :images, comment: 'Uploaded images' do |t|
      t.references :component, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.uuid :uuid, null: false, index: { unique: true }
      t.uuid :user_uuid, index: true, comment: 'Owner (UUID)'
      t.inet :ip
      t.string :image, null: false, comment: 'Attached image (for CarrierWave)'
      t.string :image_alt_text, null: false, default: ''
      t.string :caption, comment: 'Image caption for figures'
      t.string :source_name
      t.string :source_link
      t.string :checksum, index: true, comment: 'Checksum for avoiding doubles'
      t.timestamps
    end
  end
end
