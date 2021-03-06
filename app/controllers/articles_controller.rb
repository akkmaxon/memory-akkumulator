class ArticlesController < ApplicationController
  before_action :readonly_example_user, only: [:create, :update, :destroy]
  before_action :set_article, :correct_user?, only: [:edit, :update, :destroy]
  before_action :get_category, only: [:create, :update]
  before_action :save_category, only: [:update, :destroy]
  after_action :delete_category?, only: [:update, :destroy]

  def search
    param = params[:search]
    unless param.blank?
      like = "like" unless Rails.env.production?
      like ||= "ilike"
      @articles = current_user.articles.where("content #{like} :param or title #{like} :param", param: "%#{param}%")
      flash.now[:alert] = I18n.t('.search_no_matches') if @articles.empty?
    else
      flash.now[:alert] = I18n.t('.search_query_empty')
      @articles = []
    end
  end
  # GET /articles
  # GET /articles.json
  def index
  end

  # GET /articles/new
  def new
    @article = Article.new
    if request.referrer
      cat_id = request.referrer.split('/').last.to_i
      unless cat_id.to_i.eql? 0
        @referrer_category = Category.find(cat_id).title
      end
    end
    @referrer_category ||= ""
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
        format.html { redirect_to category_path(@article.category), notice: I18n.t('.article_created') }
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
        format.html { redirect_to category_path(@article.category), notice: I18n.t('.article_updated') }
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
      format.html { redirect_to articles_url, notice: I18n.t('.article_deleted') }
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
      unless @article.user.eql? current_user
        redirect_to articles_path
        flash[:alert] = I18n.t('.forbidden')
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
