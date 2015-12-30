class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :correct_user?, only: [:edit, :update]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
	log_in @user
	create_welcome_article @user
        format.html { redirect_to root_path, notice: "Hi, #{@user.name}. Your profile was successfully created." }
        format.json { render :show, status: :created, location: root_path }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
      patch_hidden_categories
        format.html { redirect_to root_path, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: root_path }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def correct_user?
      unless @user == current_user
        redirect_to root_path
        flash[:notice] = 'Forbidden place'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def feed_categories_to_hide_ids
      ids = []
      params.each do |param,value|
        if param =~ /(\d)+_category/
	  ids << param.to_i
	end
      end
      ids
    end

    def patch_hidden_categories
      categories_to_hide = feed_categories_to_hide_ids
      categories_to_hide.each do |cat_id|
        category = Category.find(cat_id)
        unless current_user.hidden_categories.include? category
	  current_user.relationships.create hidden_category_id: category.id
	end
      end
      unless current_user.hidden_categories.size.eql? categories_to_hide
        current_user.relationships.each do |rel|
	  rel.destroy unless categories_to_hide.include? rel.hidden_category_id
	end
      end
    end
end
