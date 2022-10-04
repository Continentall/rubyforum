# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  # rubocop:disable Metrics/BlockLength
  included do
    private

    # данная функция позволяет вернуть пользователя в двух ситуациях он есть в сессии или в куки
    def current_user
      user = session[:user_id].present? ? user_from_session : user_from_token

      @current_user ||= user&.decorate
    end

    def user_from_session
      User.find_by(id: session[:user_id]).decorate
    end

    def user_from_token
      user ||= User.find_by(id: cookies.encrypted[:user_id])
      token = cookies.encrypted[:remember_token]

      return unless user&.remember_token_authenticated?(token) # Уходим с функции если токен в куки и в бд не совпал

      enter_session(user)
      user
    end

    def user_signed_in?
      current_user.present?
    end

    def enter_session(local_user)
      session[:user_id] = local_user.id # Сессия - хранилище, куда пользователь сам не влезет => признак входа в аккаунт - наличие в сессии вашего id
      # Проверять это будет метод current_user в главном контроллере
    end

    def exit_session
      forget current_user
      session.delete :user_id
      @current_user = nil
    end

    def remember(user)
      user.save_remember_token
      cookies.encrypted.permanent[:remember_token] = user.remember_token # В куки сунем сам токен (encrypted шифрует куки свом шифратором)!!!! А не его хэш
      cookies.encrypted.permanent[:user_id] = user.id
    end

    def forget(user)
      user.delete_remember_token
      cookies.delete :user_id
      cookies.delete :remember_token
    end

    def require_no_authentication
      return unless user_signed_in?

      flash[:warning] = 'Вы уже зарегистрированы'
      redirect_to root_path
    end

    def require_authentication
      return if user_signed_in?

      flash[:warning] = 'Вы не зарегистрированы'
      redirect_to root_path
    end
    # по-умолчанию все методы из главного контроллера доступны только в контроллерах
    # если хотим использовать методы в представлениях xxx.html.erb то надо назначить методы хелперами
    # вот так:
    helper_method :current_user, :user_signed_in?
  end
  # rubocop:enable Metrics/BlockLength
end
