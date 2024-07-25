# frozen_string_literal: true

# Uploaded image
#
# Attributes:
#   caption [String]
#   checksum [String]
#   component_id [Component]
#   created_at [DateTime]
#   image [SimpleImageUploader], required
#   image_alt_text [String], required
#   ip [inet]
#   source_link [String]
#   source_name [String]
#   updated_at [DateTime]
#   user_uuid [UUID]
#   uuid [UUID], required
class Image < ApplicationRecord
  include HasUuid

  belongs_to :component

  mount_uploader :image, SimpleImageUploader

  validates :caption, length: { minimum: 1, maximum: 255 }, allow_blank: true
  validates :checksum, length: { minimum: 1, maximum: 128 }, allow_blank: true
  validates :image_alt_text,
            length: { minimum: 1, maximum: 255 },
            allow_blank: true
  validates :image, presence: true
  validates :source_link,
            format: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
            length: { minimum: 1, maximum: 255 },
            allow_blank: true
  validates :source_name,
            length: { minimum: 1, maximum: 255 },
            allow_blank: true
end
