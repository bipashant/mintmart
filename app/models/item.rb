class Item < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
  belongs_to :category, dependent: :destroy
  belongs_to :purchase, dependent: :destroy
  has_one :sold_item

end
