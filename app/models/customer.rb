class Customer < ActiveRecord::Base
  before_create :assign_purchased_amount



  def full_name
    [first_name,middle_name,last_name].join(' ')
  end

  private
  def assign_purchased_amount
    self.total_purchased_amount = 0
  end
end
