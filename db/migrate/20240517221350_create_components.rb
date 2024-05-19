# frozen_string_literal: true

# Create table for Component model
class CreateComponents < ActiveRecord::Migration[7.1]
  def change
    create_table :components do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.string :name, collation: 'C', null: false
      t.timestamps
    end

    add_index :components, 'lower(name)', unique: true
  end
end
