# frozen_string_literal: true

# This is a colors controller
class ColorsController < ApplicationController
  def index
    @colors = Color.paginate(page: params[:page], per_page: 10)
  end
end
