class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(refer_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "article was successfully created"
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(refer_params)
      flash[:notice] = "Article was edited"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def refer_params
    params.require(:article).permit(:title, :description)
  end

end
