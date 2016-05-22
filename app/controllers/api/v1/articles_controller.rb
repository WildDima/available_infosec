module Api
  module V1
    class ArticlesController < ApplicationController
      respond_to :json
      before_action :set_article, only: [:show]

      def index
        @articles = Article.all.order(:title)
        if params[:query].present?
          @articles = @articles.find_by_title(params[:query])
        elsif params[:first_char].present?
          @articles = @articles.find_by_char(params[:first_char][0])
        end
        @articles = @articles.paginate(page: params[:page], per_page: 20)
        respond_with @articles
      end

      def show
        respond_with @article
      end

      private

      def set_article
        @article = Article.find(params[:id])
      end
    end
  end
end