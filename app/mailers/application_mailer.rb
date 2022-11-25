# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin@itcolloquy.com'
  layout 'mailer'
end
