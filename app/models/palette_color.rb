# frozen_string_literal: true

# This is palette color model.
class PaletteColor < ApplicationRecord
  validates :palette_id, :color_id, presence: true

  belongs_to :color
  belongs_to :palette
end
