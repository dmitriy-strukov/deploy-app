class ArticlesController < ApplicationController
  respond_to :html

  def index
    @articles = Article.all.order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(article_params)
    Rails.logger.debug "#{@article.errors.full_messages}"

    respond_with @article
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    respond_with @article
  end

  def destroy
    @article = Article.find(params[:id]).destroy

    respond_with @article
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :image)
  end
end
