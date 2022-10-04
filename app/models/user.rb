# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :old_password, :remember_token # attr_accessor = attr_writer + attr_reader  позволяет создать для обьекта (тут виртуального) функции запис и чтения

  # Теперь поле old_password есть у user на не записанно в БД

  has_secure_password validations: false # Добавляет методы для регистрации и входа по паролю BCrypt. Этот механизм требует наличия в бд поля xxx_digest, где xxx имя атрибута пароля
  validate :password_presence
  validate :correct_old_password, on: :update
  validates :password, confirmation: true, allow_blank: true
  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  validate :password_complexity # validate предназначен для помещения большой валидации посредством функции

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

  private

  # Функция генерации хэша определенной сложности
  def remember_token_generate_hash(string)
    cost = if ActiveModel::SecurePassword
              .min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

    errors.add :password,
               ' complexity requirement not met. Длина должна быть от 8 до 70 символов и включать: 1 прописную букву, 1 строчную букву, 1 цифру и 1 специальный символ.'
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, ' введен неверно'
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end
end
