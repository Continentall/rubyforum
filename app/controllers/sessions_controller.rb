class SessionsController < ApplicationController
    before_action :require_no_authentication, only: %i[new create] # требуем что бы пользователь не был зарегистрирован
    before_action :require_authentication, only: :destroy
    def new

    end

    def create
        local_user = User.find_by email: params[:email] #создаем локальную переменную local_user так как больше ее нам использовать нигде не придется
        if local_user&.authenticate(params[:password]) # authenticate появился у нас благодаря has_secure_password (и он просто сверяет хеш введенных данных с хешем пароля в БД)
        # &. называется «Оператор безопасной навигации» он позволяет вам вызывать методы для объектов, не беспокоясь о том, что объект может быть nil(во избежание undefined method for nil:NilClassошибки)
            enter_session local_user
            flash[:success] = "С возвращением, #{current_user.name_or_email}!"
            redirect_to root_path
        else
            flash.now[:warning] = "Неверная эл. почта и/или пароль" # flash.now рендерит сообщение на этом же запросе // flash на следующем запросе
            render :new
        end
    end

    def destroy
        exit_session
        flash[:success] = "До скорых встреч!"
        redirect_to root_path
    end
end