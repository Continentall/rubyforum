# frozen_string_literal: true

class PasswordResetMailer < ApplicationMailer
  def reset_email
    @user = params[:user]

    mail to: @user.email, subject: I18n.t('global.password_reset_mailer.title')
  end
end
