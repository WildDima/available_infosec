require 'wikicloth'
require 'wikipedia'
require 'ruby-progressbar'

Wikipedia.Configure {
  domain 'ru.wikipedia.org'
  path   'w/api.php'
}

namespace :wiki do
  desc "wiki infosec"
  task :load, [:count] => :environment do |t, args|
    value = ['Информационная безопасность', 'RSA', 'Advanced Encryption Standard', 'Вычислительная сеть']
    count = args[:count].to_i
    counter = 0
    output = []
    progressbar = ProgressBar.create(total: count)
    value.map do |val|
      break if counter == count
      counter += 1
      page = Wikipedia.find(val)
      value << page.links unless page.links.nil? 
      value.reject! {|link| link =~ /^[0-9]/}
      value.reject! {|link| link =~ /Википедия/}
      p value
      progressbar.increment
      value.flatten!
      value.uniq!
      output = value
      if page.text.present?
        article = Article.create(title: page.title, body: WikiCloth::Parser.new(data: page.text).to_html.gsub(/\[.*?\]/, ""))
        page.image_urls.each { |image| article.images << Image.create(image: image)} unless page.image_urls.nil? 
        # page.links.each { |link| article.links << Link.create(name: link)} unless page.links.nil? 
      end
    end
  end
end