module ApplicationHelper
  def proper_search_place
    params[:action] == 'index' || params[:action] == 'show'
  end
end
