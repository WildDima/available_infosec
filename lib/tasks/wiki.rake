require 'wikicloth'
require 'wikipedia'
require 'ruby-progressbar'

Wikipedia.Configure {
  domain 'ru.wikipedia.org'
  path   'w/api.php'
}

namespace :wiki do
  desc "wiki infosec"
  task load: :environment do
    value = ['Информационная безопасность', 'RSA', 'Advanced Encryption Standard']
    count = 10
    counter = 0
    output = []
    progressbar = ProgressBar.create(total: count)
    value.map do |val|
      break if counter == count
      counter += 1
      page = Wikipedia.find(val)
      unless page.links.nil? 
        page.links.reject! {|link| link =~ /\b\d{4}\b/}
        value << page.links
      end
      progressbar.increment
      value.flatten!
      value.uniq!
      output = value
      article = Article.create(title: page.title, body: WikiCloth::Parser.new(data: page.text).to_html)
      page.image_urls.each { |image| article.images << Image.create(image: image)} unless page.image_urls.nil? 
      page.links.each { |link| article.links << Link.create(name: link)} unless page.links.nil? 
    end
  end
end