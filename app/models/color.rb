# frozen_string_literal: true

# This is a color model
class Color < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :code, presence: true
  validates :name, :code, uniqueness: { case_sensitive: false }

  scope :search, lambda { |keyword|
    where('lower(name) like :keyword OR lower(code) like :keyword',
          keyword: "%#{keyword.downcase}%")
  }
end
