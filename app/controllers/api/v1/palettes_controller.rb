# frozen_string_literal: true

module Api
  module V1
    # Palettes endpoints
    class PalettesController < BaseController
      before_action :validate_params

      def create
        palette = PaletteService.new(params)
        result = palette.create
        if result[:success]
          render_success(result[:data], result[:message])
        else
          render_failure(result[:message])
        end
      end

      private

      def validate_params
        palette = Palette.new(permit_params)
        return render_validation_errors(palette.errors) if palette.invalid?

        colors = Color.where(id: params[:color_ids])
        return if colors.present?

        render_validation_errors('color_ids is required.')
      end

      def permit_params
        params.permit(:name)
      end
    end
  end
end
