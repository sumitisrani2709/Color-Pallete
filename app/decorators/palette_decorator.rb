# frozen_string_literal: true

class PaletteDecorator < Draper::Decorator
  delegate_all

  def show_palette_swatch
    colors = "<ul class='list-group'>"
    object.colors.each do |color|
      colors += "<li class='list-group-item color-swatch' style='background-color: #{color.code};'></li>"
    end
    colors += "</ul>"
    colors
  end
end
