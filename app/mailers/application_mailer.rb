# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "shcart.app@gmail.com"
  layout "mailer"
end
