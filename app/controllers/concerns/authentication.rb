module Authentication
    extend ActiveSupport::Concern

    included do
        private

        def current_user
            @current_user ||= User.find_by(id: session[:user_id]).decorate if session[:user_id].present?
            # а ||= б  - означает если а неопределенно или ложно присваеваем а значеие б иначе не присваеваем
            # так же тут декорируется current_user
        end
    
        def user_signed_in?
            current_user.present?
        end
    
        def enter_session(local_user)
            session[:user_id] = local_user.id #Сессия - хранилище, куда пользователь сам не влезет => признак входа в аккаунт - наличие в сессии вашего id
            # Проверять это будет метод current_user в главном контроллере
        end

        def exit_session
            session.delete :user_id
            @current_user = nil
        end

        def require_no_authentication
            return if !user_signed_in?
            flash[:warning] = "Вы уже зарегистрированы"
            redirect_to root_path
        end
        def require_authentication
            return if user_signed_in?
            flash[:warning] = "Вы не зарегистрированы"
            redirect_to root_path
        end
        # по-умолчанию все методы из главного контроллера доступны только в контроллерах
        # если хотим использовать методы в представлениях xxx.html.erb то надо назначить методы хелперами 
        # вот так:
        helper_method :current_user, :user_signed_in?
    end
end