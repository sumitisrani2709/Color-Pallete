# frozen_string_literal: true

# This is a palettes controller
class PalettesController < ApplicationController
  before_action :require_color, only: %w[create update]
  before_action :find_palette, only: %w[edit update]

  def index
    @palettes = Palette.paginate(page: params[:page], per_page: 10)
  end

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

  def edit; end

  def update
    Palette.transaction do
      update_palette_and_palette_colors!
      flash[:success] = 'Palette has been updated sucessfully.'
      redirect_to palettes_path
    rescue Exception => e
      flash[:error] = e.message
      render :edit
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

  def find_palette
    @palette = Palette.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'The requested resource does not exist.'
    redirect_to(colors_path)
  end

  def require_color
    @colors = Color.where(id: params[:color_ids])
    return if @colors.present?

    flash[:error] = 'Please select atleast one color to create palette.'
    path = params[:action] == 'create' ? new_palette_path : edit_palette_path
    redirect_to path
  end

  def update_palette_and_palette_colors!
    removed_color_ids = (@palette.colors.pluck(:id) - @colors.pluck(:id))
    @palette.palette_colors.where(color_id: removed_color_ids).destroy_all
    @palette.update_attributes!(permit_params)
    @colors.each do |color|
      @palette.palette_colors.where(color_id: color.id).first_or_create!
    end
  end
end
