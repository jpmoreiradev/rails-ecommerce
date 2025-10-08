class Product < ApplicationRecord
  validates :title, :price_cents, presence: true
  validates :image_url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true
end
