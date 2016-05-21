class Article < ActiveRecord::Base
  has_many :links, dependent: :delete_all
  has_many :images, dependent: :delete_all
end
