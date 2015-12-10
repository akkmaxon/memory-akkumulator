class ArticlesController < ApplicationController
  before_action :set_article, :correct_user?, only: [:show, :edit, :update, :destroy]
  before_action :authenticate
  before_action :get_category, only: [:create, :update]
  after_action :empty_category?, only: :destroy

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    last_category = @article.category
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
    if last_category != @article.category and last_category.articles.empty?
      last_category.delete
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def correct_user?
      set_article
      unless @article.user == current_user
        redirect_to root_path
        flash[:notice] = 'Forbidden place'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      p = params.require(:article).permit(:title, :content)
      p.merge(category_id: @category.id, user_id: current_user.id)
    end
    
    def get_category
      if params[:category].empty?
        @category = Category.find_by(title: "Not specified")
      else
        if category = Category.find_by(title: params[:category].capitalize)
          @category = category
        else
          @category = Category.create(title: params[:category].capitalize)
        end
      end
    end

    def empty_category?
      if @article.category.articles.empty? and @article.category != Category.find_by(title: "Not specified")
        @article.category.delete
      end
    end
end
