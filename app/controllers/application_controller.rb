class ApplicationController < ActionController::Base
    include Pagy::Backend
    include ErrorHandling

    private

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
        # а ||= б  - означает если а неопределенно или ложно присваеваем а значеие б иначе не присваеваем
    end

    def user_signed_in?
        current_user.present?
    end
    # по-умолчанию все методы из главного контроллера доступны только в контроллерах
    # если хотим использовать методы в представлениях xxx.html.erb то надо назначить методы хелперами 
    # вот так:
    helper_method :current_user, :user_signed_in?
end
