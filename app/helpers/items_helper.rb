module ItemsHelper

  def render_tabs(record)
    content_tag(:span,
                link_to(content_tag(:span, '',class: "glyphicon glyphicon-zoom-in icon-white") + 'View',
                        "/items/#{record.id}/",
                        class: 'create_organization_btn btn btn-success'
                ) +

                link_to(content_tag(:span, '', class: 'fa fa-pencil-square-o') + 'Update',
                        "/items/#{record.id}/edit",
                        class: 'create_organization_btn btn btn-info'
                )+

                link_to(content_tag(:span, '', class: 'glyphicon glyphicon-trash icon-white') + 'Delete',"/items/#{record.id}",method: :delete,data: { confirm: 'Are you sure?' }, class: 'btn btn-danger'
                )

    )
  end

end
