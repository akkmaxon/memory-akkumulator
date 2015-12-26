class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  protected 

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    unless current_user
      redirect_to login_url
    end
  end
  
  def log_in user
    session[:user_id] = user.id
  end

  def create_welcome_article(user)
    app_name = "Memory Akkumulator"
    article = Article.create(
      title: "Welcome to #{app_name}!",
      content: "Hi, this is your help file. I am not ready yet.",
      user_id: user.id,
      category_id: Category.find_by(title: "Not specified").id)
  end
end
