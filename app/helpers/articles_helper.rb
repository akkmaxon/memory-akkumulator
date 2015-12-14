module ArticlesHelper
  def random_articles
    articles = current_user.articles
    random_articles = []
    articles_on_page = 3
    articles_on_page.times do
      random_articles << articles.limit(1).offset(rand(articles.count)).first
    end
    random_articles.uniq
  end
end
