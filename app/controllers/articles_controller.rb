class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  def index
    @articles = Article.all.order(:title)
    if params[:query].present?
      @articles = @articles.find_by_title(params[:query])
    elsif params[:first_char].present?
      @articles = @articles.find_by_char(params[:first_char][0])
    end
  end

  def show
  end

  private

  def set_article
    @article = Article.find(params[:id])
    # @article = Article.includes(:images).where('articles.id = ?', params[:id])
  end
end
