class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!, except: :welcome
  protect_from_forgery with: :exception

  protected

  def readonly_example_user
    if current_user.email.eql? "user@example.com"
      redirect_to articles_path
      flash[:alert] = 'Please, sign up and do whatever you want'
    end
  end
end
