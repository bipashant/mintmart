class Sale < ActiveRecord::Base
  has_many :sold_items
  belongs_to :customer
end
