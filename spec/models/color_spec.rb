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
end
