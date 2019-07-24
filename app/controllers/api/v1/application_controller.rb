# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      include ExceptionHandler
    end
  end
end
