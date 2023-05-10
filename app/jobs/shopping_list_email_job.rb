# frozen_string_literal: true

class ShoppingListEmailJob < ApplicationJob
  queue_as :default
  def perform
    emails = ShoppingListEmail.where(was_send: false, send_date: Date.today)
    emails.each do |email|
      ShoppingListMailer.with(shopping_list: email.shopping_list).shopping_list_email.deliver_now
      email.update(was_send: true)
    end
  end
end
