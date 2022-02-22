# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name('info@dvpweb.ru', 'TODO-сайт')
  layout 'mailer'
end
