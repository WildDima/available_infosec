class FeedsController < ApplicationController
  def index
    @feeds = ParseRss.call(url: ['https://news.yandex.ru/security.rss','http://www.anti-malware.ru/news/feed'])
    @feeds = @feeds.feeds.flatten.sort_by {|news| news.pubDate}.reverse
  end
end
