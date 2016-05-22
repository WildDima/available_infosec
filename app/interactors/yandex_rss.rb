require 'open-uri'

class YandexRss
  include Interactor

  def call
    doc = Nokogiri::XML(open("https://news.yandex.ru/security.rss"))
    context.yandex_rss = doc.at('channel').children.map { |feed| feed.children.children} 
    context.yandex_rss
  end
end
