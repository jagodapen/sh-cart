require "rails_helper"

RSpec.describe ShoppingListMailer, type: :mailer do
  let(:shopping_list) { build(:shopping_list) }
  let(:shopping_list_without_email) do
    name { 'SH Name' }
    shopping_day { '2022-03-25' }
    status { 0 }
  end
  let(:shopping_list_email) { build(:shopping_list_email) }
  let(:mail) { ShoppingListMailer.with(shopping_list: shopping_list).shopping_list_email }
  let(:attachment) { mail.attachments[0] }
  let(:html_body) do
    mail.body.parts.find { |p| p.content_type.match 'text/html' }.body.raw_source
  end

  it "renders the headers" do
    expect(mail.subject).to eq("Shopping List to MyString")
    expect(mail.to).to eq(["example@email.com"])
    expect(mail.from).to eq(["shcart.app@gmail.com"])
  end

  pending "renders the body" do
    expect(mail.body).to start_with("Hi there!")
  end

  it "adds csv attachment" do
    shopping_list.shopping_list_email[:file_format] = 1
    expect(attachment.filename).to end_with(".csv")
  end

  it "adds pdf attachment" do
    shopping_list.shopping_list_email[:file_format] = 2
    expect(attachment.filename).to end_with(".pdf")
  end


  it "adds xls attachment" do
    expect(attachment.filename).to end_with(".xlsx")
  end
end
