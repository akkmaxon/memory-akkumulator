class ArticlesController < ApplicationController
  before_action :set_article, :correct_user?, only: [:show, :edit, :update, :destroy]
  before_action :authenticate
  before_action :get_category, only: [:create, :update]
  before_action :save_category, only: [:update, :destroy]
  after_action :delete_category?, only: [:update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = current_user.articles
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
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
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
        if category = Category.find_by(title: params[:category])
          @category = category
        else
          @category = Category.create(title: params[:category])
        end
      end
    end

    def save_category
      set_article
      session[:category] = @article.category.title
    end

    def delete_category?
      category = Category.find_by(title: session[:category])
      session.delete(:category)
      if category.articles.empty? and category.title != "Not specified"
        category.delete
      end
    end
end
