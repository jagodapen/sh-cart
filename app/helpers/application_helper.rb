module ApplicationHelper
  def all_products
    Product.all
  end

  def grouped_products
    Product.all.group_by(&:product_type)
  end

  def add_object_link(name, form, object, partial, where)
    html = render(partial:, locals: { form: }, object:)
    link_to_function name, %{
      var new_object_id = new Date().getTime() ;
      var html = jQuery(#{js html}.replace(/NEW_RECORD/g, new_object_id)).hide();
      html.appendTo(jQuery("#{where}")).slideDown('slow');
    }
  end
end
