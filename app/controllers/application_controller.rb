class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  protected 

  def create_welcome_article(user)
    app_name = "Memory Akkumulator"
    article = Article.create(
      title: "Welcome to #{app_name}!",
      content: "Hi, this is your help file. I am not ready yet.",
      user_id: user.id,
      category_id: Category.find_by(title: "Not specified").id)
  end
end
