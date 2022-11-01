# frozen_string_literal: true

module Admin
  # в отличнии от обычного контроллера тут надо написать пространство имен и ::
  class UsersController < BaseController
    before_action :require_authentication
    before_action :set_user!, only: %i[edit update destroy]
    before_action :authorize_user!
    after_action :verify_authorized
    def index
      respond_to do |format| # указываем что в зависимости от формата вызова метода делаем разные вещи
        format.html do
          @pagy, @users = pagy User.order(created_at: :desc)
        end
        format.zip do
          respond_with_zipperd_users
        end
      end
    end

    def edit; end

    def create
      if params[:archive].present? # Проверка передан ли архив
        UserBulkService.call params[:archive] # Вызов сервисного класса и передача ему архива
        flash[:success] = 'Пользователи добавлены'
      end
      redirect_to admin_users_path
    end

    def update
      if @user.update user_params
        flash[:success] = t 'admin.users.user.edit'
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      flash[:success] = t 'admin.users.user.destroy'
      redirect_to admin_users_path
    end

    private

    def set_user!
      @user = User.find params[:id]
    end

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :role).merge(admin_edit: true)
    end

    def respond_with_zipperd_users
      compressed_filestream = Zip::OutputStream.write_buffer do |zos| # Генереруем временный архив compressed_filestream
        User.order(created_at: :desc).each do |user| # цикл который для каждого пользователя в БД будет выполнять код ниже
          zos.put_next_entry "user_#{user.id}.xlsx" # put_next_entry - команда из gem rubyzip она добаляет файл в архив
          zos.print render_to_string( # render_to_string ренерит представление не на экран а в память (в виде строки)
            lauout: false, handlers: [:axlsx], formats: [:xlsx], template: 'admin/users/user', locals: { user: }
          )
          # lauout: false - указывает на рендеринг без lauout | handlers - указывает на выбор обработчика шаблона |
          # formats - формат текста | template - представление которое мы будем рендерить в строку (тут xlsx файлик)|
          # локальная переменная передаваемая |
        end
      end
      compressed_filestream.rewind # возвращаем итератор записи\чтения файла в начало
      send_data compressed_filestream.read, filename: 'users.zip' # send_data встроенный ruby метод, что даст скачать файл
    end

    def authorize_user!
      authorize(@user || User)
    end
  end
end
