# frozen_string_literal: true

class User < ApplicationRecord
  include Recoverable
  include Rememberable
  enum role: { basic: 0, moderator: 1, admin: 2 }, _suffix: :role
  attr_accessor :old_password, :admin_edit # attr_accessor = attr_writer + attr_reader  позволяет создать для обьекта (тут виртуального) функции запис и чтения

  # Теперь поле old_password есть у user на не записанно в БД

  has_secure_password validations: false # Добавляет методы для регистрации и входа по паролю BCrypt. Этот механизм требует наличия в бд поля xxx_digest, где xxx имя атрибута пароля

  has_many :topics, dependent: :destroy
  has_many :messages, dependent: :destroy

  validate :password_presence
  validate :correct_old_password, on: :update, if: -> { password.present? && !admin_edit }
  validates :password, confirmation: true, allow_blank: true
  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  validate :password_complexity # validate предназначен для помещения большой валидации посредством функции
  validates :role, presence: true

  before_save :set_gravatar_hash, if: :email_changed? # вызов функции перед сохранением или обновлении email

  def guest?
    false
  end

  def author?(obj)
    obj.user == self
  end

  private

  def set_gravatar_hash
    return if email.blank?

    hash = Digest::MD5.hexdigest email.strip.downcase # Генерация хэша на основе E-mail пользователя
    self.gravatar_hash = hash # записываем в БД хэш
  end

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
