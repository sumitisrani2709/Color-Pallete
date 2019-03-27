# frozen_string_literal: true

module Api
  module V1
    # ::no dock
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      def render_failure(message, status = 500)
        render status: status, json: {
          success: false,
          error: message
        }
      end

      def render_validation_errors(message, status = 422)
        render status: status, json: {
          success: false,
          error: message
        }
      end

      def render_success(data, message = '')
        render status: :ok, json: {
          success: true,
          data: data,
          message: message
        }
      end

      def process_action(*args)
        super
      rescue ActionDispatch::Http::Parameters::ParseError => exception
        render status: :bad_request, json: { errors: [exception.message] }
      end
    end
  end
end
