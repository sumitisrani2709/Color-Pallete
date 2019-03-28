# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaletteColor, type: :model do
  it { should validate_presence_of(:palette_id) }
  it { should validate_presence_of(:color_id) }
  it { should belong_to(:color) }
  it { should belong_to(:palette) }
end
