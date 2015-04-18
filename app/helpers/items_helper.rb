module ItemsHelper

  def render_tabs(record)
    content_tag(:span,
                link_to(content_tag(:span, '',class: "glyphicon glyphicon-zoom-in icon-white") + 'View',
                        "/items/#{record.id}/",
                        class: 'create_organization_btn btn btn-success',
                        id: "create_organization_btn-#{record.id}"
                ) +
                    link_to(content_tag(:span, '', class: 'fa fa-pencil-square-o') + 'Update',
                            "/items/#{record.id}/edit",
                            class: 'create_organization_btn btn btn-info',
                            id: "create_organization_btn-#{record.id}"
                    )
    )
  end

end
