require 'rss'
require 'open-uri'

class ParseRss
  include Interactor

  def call
    context.url.each do |url|
      open(url) do |rss_feed|
        feed = RSS::Parser.parse(rss_feed)
        context.feeds ||= []
        context.feeds << feed.items.each { |item| {title: item.title, link: item.link, description: item.description} }
      end
    end
  end
end