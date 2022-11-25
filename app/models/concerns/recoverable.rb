module Recoverable
    extend ActiveSupport::Concern

    included do
        def set_password_reset_token
            update password_reset_token: remember_token_generate_hash(SecureRandom.urlsafe_base64), password_reset_token_sent_at: Time.current
        end
    end
end