module ItemsHelper
  def render_tabs(record)
    content_tag(:span,
                link_to( content_tag(:span, '',class: 'glyphicon glyphicon-edit icon-white') + 'Update',edit_item_path(record),class: 'btn btn-info'),
                         "/organizations/#{record.id}/edit",
                         class: 'create_organization_btn btn btn-primary',
                         id: "create_organization_btn-#{record.id}"
                )
  end
end
