module SalesHelper
  def options_for_categories
    @categories.map do |category|
      [category.name.humanize, category.id]
    end
  end
end
