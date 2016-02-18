class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_i18n_locale_from_params
  before_action :authenticate_user!, except: [:welcome, :change_locale]
  protect_from_forgery with: :exception

  def change_locale
    if params[:set_locale]
      redirect_to root_path(locale: params[:set_locale])
    end
  end


  protected

  def readonly_example_user
    if current_user.email.eql? "user@example.com"
      redirect_to articles_path
      flash[:alert] = I18n.t('.readonly_alert')
    end
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
	I18n.locale = params[:locale]
      else
	flash.now[:alert] = "#{params[:locale]} translation is not available"
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
