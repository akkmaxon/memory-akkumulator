module ArticlesHelper
  def random_articles
    articles = current_user.articles
    random_articles = []
    articles_on_page = 3
    while(random_articles.uniq.size < 3) do
      random_articles << articles.limit(1).offset(rand(articles.count)).first
    end
    random_articles.uniq
  end
end
