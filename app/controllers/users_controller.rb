class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new get_user_params
        if @user.save
            session[:user_id] = @user.id #Сессия - хранилище, куда пользователь сам не влезет => признак входа в аккаунт - наличие в сессии вашего id
            # Проверять это будет метод current_user в главном контроллере
            flash[:success] = "Добро пожаловать, #{@user.name}"
            redirect_to root_path
        else
            render :new
        end
    end

    private

    def get_user_params
        params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end