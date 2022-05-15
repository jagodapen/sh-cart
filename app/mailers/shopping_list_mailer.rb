class ShoppingListMailer < ApplicationMailer
  def shopping_list_email
    @shopping_list = params[:shopping_list]
    email = @shopping_list.shopping_list_email
    export_xlsx(@shopping_list)
    mail(to: email.recipient, subject: "Shopping List to #{@shopping_list.name}")
  end

  def export_xlsx(shopping_list)
    xlsx = render_to_string layout: false, handlers: [:axlsx], formats: [:xlsx], template: "shopping_lists/show", locals: {shopping_list: @shopping_list}
    attachment = Base64.encode64(xlsx)
    attachments["shopping_list-#{@shopping_list.name}-#{@shopping_list.shopping_day}.xlsx"] = {mime_type: Mime[:xlsx], content: attachment, encoding: 'base64'}
  end
end
