module ApplicationHelper
  def proper_search_place
    params[:action] == 'index' || params[:action] == 'show'
  end

  def full_title(app_title)
    if current_user
      current_user.name + " | " + app_title 
    else
      app_title
    end
  end
end
