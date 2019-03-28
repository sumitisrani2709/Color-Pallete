# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaletteService do
  describe 'create Palette' do
    let!(:color) { create(:color) }
    it 'Should create palette' do
      options = { name: 'palette-1', color_ids: Color.pluck(:id) }
      palette_service = PaletteService.new(options)
      result = palette_service.create
      expect(result[:success]).to be_truthy
      expect(result[:message]).to eq('Palette has been created sucessfully.')
      expect(result[:data].present?).to be_truthy
    end

    it 'Should not create palette' do
      options = { name: nil, color_ids: Color.pluck(:id) }
      palette_service = PaletteService.new(options)
      result = palette_service.create
      expect(result[:success]).to be_falsy
      expect(result[:message]).to eq('Validation failed: Name can\'t be blank')
    end
  end
end
