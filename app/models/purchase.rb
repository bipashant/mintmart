class Purchase < ActiveRecord::Base
  has_many :items
  belongs_to :supplier
end
