module CategoriesHelper
  def user_categories
    #returns array of titles
    categories = []
    Category.all.each do |category|
      category.articles.each do |article|
        if article.user == current_user
	  categories << category.title
	end
      end
    end
    categories.uniq
  end
end
