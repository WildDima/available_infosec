class FeedsController < ApplicationController
  def index
    @feeds = YandexRss.call.yandex_rss
    @feeds.reject! { |c| c.empty? }.shift
  end
end
