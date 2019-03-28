# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PalettesController, type: :controller do
  describe 'create Palette' do
    let!(:palettte_1) { FactoryBot.create(:palette, name: 'palette-123') }
    let!(:color) { create(:color) }
    let!(:params) do
      { palette: { name: 'palette-2' },
        color_ids: Color.pluck(:id) }
    end

    it 'Should create palette' do
      post :create, params: params
      expect(flash[:success]).to eq('Palette has been created sucessfully.')
      response.should redirect_to(palettes_path)
    end

    it 'Should not create palette without name' do
      post :create, params: params.merge!(palette: { name: nil })
      expect(flash[:error]).to eq('Validation failed: Name can\'t be blank')
      response.should redirect_to(new_palette_path)
    end

    it 'Should not create palette without color_ids' do
      post :create, params: params.merge!(color_ids: [])
      message = 'Please select atleast one color to create palette.'
      expect(flash[:error]).to eq(message)
      response.should redirect_to(new_palette_path)
    end

    it 'Should not create palette with a existing name' do
      post :create, params: params.merge!(palette: { name: palettte_1.name })
      message = 'Validation failed: Name has already been taken'
      expect(flash[:error]).to eq(message)
      response.should redirect_to(new_palette_path)
    end
  end
end
