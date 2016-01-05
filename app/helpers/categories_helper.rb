module CategoriesHelper
  def current_user_categories
    categories = []
    current_user.articles.each do |article|
      categories << article.category
    end
    categories.uniq
  end
end
