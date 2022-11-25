class PasswordResetsController < ApplicationController
    before_action :require_no_authentication
    
    def create
        @user = User.find_by email: params[:email]

        if @user.present?
            @user.set_password_reset_token
        
            PasswordResetMailer.with(user: @user).reset_email.deliver_later
        end
        flash[:success] = t 'global.flash.user.reset_password_message_send'
        redirect_to new_session_path
    end
end