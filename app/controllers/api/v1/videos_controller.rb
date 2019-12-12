module Api
  module V1
    # app/controllers/api/v1/videos_controller.rb
    class VideosController < ApplicationController
      def show
        render json: Video.find(params[:id])
      end
    end
  end
end
