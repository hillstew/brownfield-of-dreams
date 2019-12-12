module Api
  module V1
    # app/controllers/api/v1/tutorials_controller.rb
    class TutorialsController < ApplicationController
      def index
        render json: Tutorial.all
      end

      def show
        render json: Tutorial.find(params[:id])
      end
    end
  end
end
