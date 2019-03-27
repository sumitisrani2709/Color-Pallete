# frozen_string_literal: true

# This is a palettes controller
class PalettesController < ApplicationController
  before_action :require_color, only: %w[create update]
  before_action :find_palette, only: %w[show edit update destroy]

  def index
    @palettes = Palette.all
    @palettes = @palettes.search(params[:search]) if params[:search].present?
    @palettes = @palettes.order('created_at DESC')
                         .paginate(page: params[:page], per_page: 10)
  end

  def new
    @palette = Palette.new
  end

  def create
    options = permit_params.merge(color_ids: @colors.pluck(:id))
    palette = PaletteService.new(options)
    result = palette.create
    if result[:success]
      flash[:success] = result[:message]
      redirect_to palettes_path
    else
      flash[:error] = result[:message]
      redirect_to new_palette_path
    end
  end

  def show; end

  def edit; end

  def update
    Palette.transaction do
      update_palette_and_palette_colors!
      flash[:success] = 'Palette has been updated sucessfully.'
      redirect_to palettes_path
    rescue StandardError, ActiveRecord::Rollback => e
      flash[:error] = e.message
      render :edit
      raise ActiveRecord::Rollback
    end
  end

  def destroy
    if @palette.destroy
      flash[:success] = 'palette has been deleted sucessfully.'
    else
      flash[:error] = @palette.errors.full_messages.join('<br>')
    end
    redirect_to palettes_path
  end

  private

  def permit_params
    params.require(:palette).permit(:name)
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
