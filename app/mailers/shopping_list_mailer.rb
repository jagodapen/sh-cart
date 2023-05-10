# frozen_string_literal: true

class ShoppingListMailer < ApplicationMailer
  def shopping_list_email
    @shopping_list = params[:shopping_list]
    email = @shopping_list.shopping_list_email
    @file_name = "shopping_list-#{@shopping_list.name}-#{@shopping_list.shopping_day}"
    public_send("export_#{@shopping_list.shopping_list_email.file_format}")
    mail(to: email.recipient, subject: "Shopping List to #{@shopping_list.name}")
  end

  def export_xlsx
    xlsx = render_to_string layout: false,
                            handlers: [:axlsx],
                            formats: [:xlsx],
                            template: "shopping_lists/show",
                            locals: { shopping_list: @shopping_list }
    attachment = Base64.encode64(xlsx)
    attachments["#{@file_name}.xlsx"] = { mime_type: Mime[:xlsx], content: attachment, encoding: "base64" }
  end

  def export_pdf
    pdf = ShoppingListPdf.new(@shopping_list)
    attachments["#{@file_name}.pdf"] = { mime_type: Mime[:pdf], content: pdf.render }
  end

  def export_csv
    csv = render_to_string  layout: false,
                            formats: [:csv],
                            template: "shopping_lists/show",
                            locals: { shopping_list: @shopping_list }
    attachments["#{@file_name}.csv"] = { mime_type: "text/csv", content: csv }
  end
end
