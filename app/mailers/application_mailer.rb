# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'hamza.amer@devsinc.com'
  layout 'mailer'
end
