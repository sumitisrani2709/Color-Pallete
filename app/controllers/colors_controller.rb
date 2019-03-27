# frozen_string_literal: true

# This is a colors controller
class ColorsController < ApplicationController
  def index
    @colors = Color.paginate(page: params[:page], per_page: 10)
  end

  def new
    @color = Color.new
  end

  def create
    @color = Color.new(permit_params)
    if @color.save
      flash[:success] = 'Color has been created sucessfully.'
      redirect_to colors_path
    else
      flash[:error] = @color.errors.full_messages.join('<br>').html_safe
      render :new
    end
  end

  private

  def permit_params
    params.require(:color).permit(:name, :code)
  end
end
