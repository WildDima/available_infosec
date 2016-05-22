class Article < ActiveRecord::Base
  include PgSearch
  has_many :links, dependent: :delete_all
  has_many :images, dependent: :delete_all

  pg_search_scope :find_by_title,
                  against: :title,
                  using: :trigram

  pg_search_scope :find_by_char,
                  against: :title,
                  using:{ 
                    tsearch: {prefix: true}
                  }
end
