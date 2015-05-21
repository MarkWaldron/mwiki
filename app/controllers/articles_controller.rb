class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :destroy, :update]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    if params[:category].blank?
      @articles = Article.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @articles = Article.where(category_id: @category_id).order("created_at DESC")
    end
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def destroy
    if @article.user == current_user
      @article.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def update
    if @article.update(article_params) && @article.user == current_user
      redirect_to @article
    else
      render 'edit'
    end

  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :category_id)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
