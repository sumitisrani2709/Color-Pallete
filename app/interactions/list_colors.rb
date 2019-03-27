# frozen_string_literal: true

# This is a interaction to list all colors
class ListColors < ActiveInteraction::Base
  string :page, default: '1'
  integer :per_page, default: 10
  string :search, default: nil

  def execute
    color = Color.all
    color = color.search(search) if search.present?
    color.order('created_at DESC').paginate(page: page, per_page: per_page)
  end
end
