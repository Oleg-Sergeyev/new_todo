# frozen_string_literal: true

class NotifyMailer < ApplicationMailer
  def user_deadlines(email, events)
    @events = events
     # attachments['attach.png'] = File.read(Rails.root.join('public/logo.png').to_s)
    mail(
      to: email,
      subject: I18n.t('emails.subjects.user_deadlines')
    )
  end
end
