class Color < ApplicationRecord
  validates :name, :code, presence: true
  validates :name, :code, uniqueness: { case_sensitive: false }
end
