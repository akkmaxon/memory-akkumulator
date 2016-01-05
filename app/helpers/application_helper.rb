module ApplicationHelper
  def proper_search_place
    actions = %q{ index show search }
    actions.include? params[:action]
  end

  def full_title(app_title)
    if current_user
      app_title + " | " + current_user.email
    else
      app_title
    end
  end
end
