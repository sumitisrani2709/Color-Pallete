# frozen_string_literal: true

module Api
  module V1
    # Colors endpoints
    class ColorsController < BaseController
      def index
        data = ListColors.run(page: params[:page], per_page: 10).result
        render_success(data)
      end
    end
  end
end
