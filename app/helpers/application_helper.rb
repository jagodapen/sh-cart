# frozen_string_literal: true

module ApplicationHelper
  def add_object_link(name, form, object, partial, where)
    html = render(partial:, locals: { form: }, object:)
    link_to_function name, %Q{
      var new_object_id = new Date().getTime() ;
      var html = jQuery(#{js html}.replace(/NEW_RECORD/g, new_object_id)).hide();
      html.appendTo(jQuery("#{where}")).slideDown('slow');
    }
  end
end
