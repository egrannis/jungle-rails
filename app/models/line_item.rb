class LineItem < ApplicationRecord

  belongs_to :order # active record relationships (one to many)
  belongs_to :product

  monetize :item_price_cents, numericality: true
  monetize :total_price_cents, numericality: true

end
