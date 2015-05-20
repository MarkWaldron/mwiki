class Article < ActiveRecord::Base
  def index
    @article = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

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
  end

  def update
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
