class Purchase < ActiveRecord::Base
  has_many :purchased_items
  belongs_to :supplier
end
