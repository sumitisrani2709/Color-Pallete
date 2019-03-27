# frozen_string_literal: true

# This is a palette service
class PaletteService
  def initialize(options)
    @name = options[:name]
    @color_ids = options[:color_ids]
  end

  def create
    result = {}
    Palette.transaction do
      create_palette_and_palette_colors!
      message = 'Palette has been created sucessfully.'
      result = { success: true, message: message }
    rescue Exception => e
      result = { success: false, message: e.message }
      raise ActiveRecord::Rollback
    end
    result
  end

  private

  def create_palette_and_palette_colors!
    palette = Palette.new(name: @name)
    palette.save!
    colors = Color.where(id: @color_ids)
    data = colors.collect do |color|
      { color_id: color.id,
        palette_id: palette.id }
    end
    PaletteColor.create!(data)
  end
end
