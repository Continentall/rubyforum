module Rememberable
    extend ActiveSupport::Concern

    included do 
        attr_accessor :remember_token
        def save_remember_token
            self.remember_token = SecureRandom.urlsafe_base64 # генерируем некоторую строку а-ля пароль
            # rubocop:disable Rails/SkipsModelValidations
            update_column :remember_token_digest, remember_token_generate_hash(remember_token) # хэшируем эту строку и записываем в БД в поле :remember_token_digest
            # rubocop:enable Rails/SkipsModelValidations
            # self.remember_token - виртуальный аттрибут у user'а
          end
        
          def delete_remember_token
            # rubocop:disable Rails/SkipsModelValidations
            update_column :remember_token_digest, nil
            # rubocop:enable Rails/SkipsModelValidations
            self.remember_token = nil
          end
        
          def remember_token_authenticated?(remember_token)
            return false if remember_token_digest.blank?
        
            BCrypt::Password.new(remember_token_digest).is_password?(remember_token) # Сравнение дайджест токена в бд с дайджест токеном у пользователем
          end
    end
end