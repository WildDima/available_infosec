json.articles @articles do |article|
  json.title article.title
  json.images article.images, :image
  json.link api_v1_article_path(article)
end