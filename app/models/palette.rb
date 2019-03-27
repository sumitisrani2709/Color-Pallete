# frozen_string_literal: true

# This is palette model.
class Palette < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :palette_colors, dependent: :destroy
  has_many :colors, through: :palette_colors

  scope :search, lambda { |keyword|
    where('lower(name) like ?',
          "%#{keyword.downcase}%")
  }
end
