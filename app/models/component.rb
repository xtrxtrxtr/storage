# frozen_string_literal: true

# Component
#
# Attributes:
#   created_at [DateTime]
#   name [String], required
#   updated_at [DateTime]
#   uuid [UUID], required
class Component < ApplicationRecord
  include HasUuid

  validates :name,
            presence: true,
            uniqueness: true,
            format: /\A[a-z_0-9]+\z/,
            length: { minimum: 3, maximum: 50 }
end
