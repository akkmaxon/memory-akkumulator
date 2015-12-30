module ArticlesHelper
  def feed_articles
    articles = all_articles_to_show_in_feed
    random_articles = []
    max_count = 3
    if articles.size < max_count
      articles_on_page = articles.size
    else
      articles_on_page = max_count
    end
    while(random_articles.uniq.size < articles_on_page) do
      random_articles << articles[rand(articles.size)]
    end
    random_articles.uniq
  end

  def all_articles_to_show_in_feed
    result = []
    articles = current_user.articles
    articles.each do |article|
      result << article unless current_user.hidden_categories.include? article.category
    end
    result
  end
end
