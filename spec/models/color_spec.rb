# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Color, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:code) }

  describe 'uniqueness' do
    subject { Color.new(name: 'white', code: '#fff') }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_uniqueness_of(:code).case_insensitive }
  end

  describe '#search' do
    let!(:color1) { create(:color) }
    let!(:color2) { FactoryBot.create(:color, name: 'white1', code: '#efedf0') }
    let!(:color3) { FactoryBot.create(:color, name: 'black', code: '#0f0f0f') }

    it 'should return colors which have keyword in name or code' do
      colors = Color.search('white')
      expect(colors.length).to eq 2
      expect(colors.pluck(:id).include?(color1.id)).to be_truthy
      expect(colors.pluck(:id).include?(color2.id)).to be_truthy
    end

    it 'should not return color which does not match keyword in name or code' do
      expect(Color.search('white').pluck(:id).include?(color3.id)).to be_falsy
    end
  end
end
