class User < ApplicationRecord
    attr_accessor :old_password # attr_accessor = attr_writer + attr_reader  позволяет создать для обьекта (тут виртуального) функции запис и чтения
    # Теперь поле old_password есть у user на не записанно в БД

    
    has_secure_password validations: false # Добавляет методы для регистрации и входа по паролю BCrypt. Этот механизм требует наличия в бд поля xxx_digest, где xxx имя атрибута пароля
    validate :password_presence
    validate :correct_old_password, on: :update
    validates :password, confirmation: true, allow_blank:true
    validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
    validate :password_complexity #validate предназначен для помещения большой валидации посредством функции 
    
    private
    def password_complexity
        # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
        return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/
    
        errors.add :password, ' complexity requirement not met. Длина должна быть от 8 до 70 символов и включать: 1 прописную букву, 1 строчную букву, 1 цифру и 1 специальный символ.'
    end

    def correct_old_password
        return if BCrypt::Password.new(password_digest_was).is_password?(old_password) # Сравнение дайджест пароля в бд с дайджест паролем введенным пользователем
        
        errors.add :old_password, ' введен неверно'
    end

    def password_presence
        errors.add(:password, :blank) unless password_digest.present? # Если password_digest есть, то поле пароля может быть пустое
    end
end
