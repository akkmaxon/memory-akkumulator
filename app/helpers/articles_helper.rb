module ArticlesHelper
  def random_articles
    articles = current_user.articles
    random_articles = []
    if articles.size < 3
      articles_on_page = articles.size
    else
      articles_on_page = 3
    end
    while(random_articles.uniq.size < articles_on_page) do
      random_articles << articles.limit(1).offset(rand(articles.count)).first
    end
    random_articles.uniq
  end

end
