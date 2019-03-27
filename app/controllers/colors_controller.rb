# frozen_string_literal: true

# This is a colors controller
class ColorsController < ApplicationController
  before_action :find_color, only: %w[show edit update destroy]
  def index
    @colors = Color.paginate(page: params[:page], per_page: 10)
  end

  def new
    @color = Color.new
  end

  def create
    respond_to do |format|
      format.js {}
      if create_color?
        flash[:success] = 'Color has been created sucessfully.'
        format.html { redirect_to colors_path }
      else
        flash[:error] = @color.errors.full_messages.join('<br>').html_safe
        format.html { render :new }
      end
    end
  end

  def show; end

  def edit; end

  def update
    if @color.update_attributes(permit_params)
      flash[:success] = 'Color has been updated sucessfully.'
      redirect_to colors_path
    else
      flash[:error] = @color.errors.full_messages.join('<br>')
      render :edit
    end
  end

  def destroy
    if @color.destroy
      flash[:success] = 'Color has been deleted sucessfully.'
    else
      flash[:error] = @color.errors.full_messages.join('<br>')
    end
    redirect_to colors_path
  end

  private

  def permit_params
    params.require(:color).permit(:name, :code)
  end

  def find_color
    @color = Color.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'The requested resource does not exist.'
    redirect_to(colors_path)
  end

  def create_color?
    @color = Color.new(permit_params)
    @color.save
  end
end
