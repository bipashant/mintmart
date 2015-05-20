module SalesHelper
  def options_for_categories
    @categories.map do |category|
      [category.name.humanize, category.id]
    end
  end

  def render_tabs(record)
    content_tag(:span,
                link_to(content_tag(:span, '',class: "glyphicon glyphicon-zoom-in icon-white") + 'View',
                        "/sales/#{record.id}/",
                        class: 'create_organization_btn btn btn-success'
                ))
  end
end
