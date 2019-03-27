# frozen_string_literal: true

# This is a palettes controller
class PalettesController < ApplicationController
  before_action :require_color, only: %w[create]

  def new
    @palette = Palette.new
  end

  def create
    Palette.transaction do
      create_palette_and_palette_colors!
      flash[:success] = 'Palette has been created sucessfully.'
      redirect_to palettes_path
    rescue Exception => e
      flash[:error] = e.message
      render :new
      raise ActiveRecord::Rollback
    end
  end

  private

  def permit_params
    params.require(:palette).permit(:name)
  end

  def create_palette_and_palette_colors!
    @palette = Palette.new(permit_params)
    @palette.save!
    @colors.each { |color| @palette.palette_colors.create!(color_id: color.id) }
  end

  def require_color
    @colors = Color.where(id: params[:color_ids])
    return if @colors.present?

    flash[:error] = 'Please select atleast one color to create palette.'
    path = params[:action] == 'create' ? new_palette_path : edit_palette_path
    redirect_to path
  end
end
