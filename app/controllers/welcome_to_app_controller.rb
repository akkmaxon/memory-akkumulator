class WelcomeToAppController < ApplicationController
  def welcome
    if signed_in?
      redirect_to articles_path
    end
  end
end
