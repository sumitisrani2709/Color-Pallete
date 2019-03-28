# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Palette, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:palette_colors) }
  it { should have_many(:colors).through(:palette_colors) }

  describe 'uniqueness' do
    subject { Palette.new(name: 'palette1') }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'dependent destroy' do
    let!(:palette_color) { create(:palette_color) }

    it 'Delete palette should delete associate palette colors too' do
      palete_count = PaletteColor.count
      expect { palette_color.palette.destroy }.to change { palete_count }.by(-1)
    end
  end

  describe '#search' do
    let!(:palette_1) { create(:palette) }
    it 'should return search palette' do
      palette = Palette.search(palette_1.name)
      expect(palette.pluck(:id).include?(palette_1.id)).to be_truthy
    end

    it 'should not return search palette' do
      palette = Palette.search('no-palette')
      expect(palette.pluck(:id).include?(palette_1.id)).to be_falsy
    end
  end
end
