# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create] # требуем что бы пользователь не был зарегистрирован
  before_action :require_authentication, only: :destroy
  def new; end

  def create
    if @user&.authenticate(params[:password]) # authenticate появился у нас благодаря has_secure_password (и он просто сверяет хеш введенных данных с хешем пароля в БД)
      # &. называется «Оператор безопасной навигации» он позволяет вам вызывать методы для объектов, не беспокоясь о том, что объект может быть nil(во избежание undefined method for nil:NilClassошибки)
      sign_in(@user)
    else
      flash.now[:warning] = 'Неверная эл. почта и/или пароль' # flash.now рендерит сообщение на этом же запросе // flash на следующем запросе
      render :new
    end
  end

  def destroy
    exit_session
    flash[:success] = 'До скорых встреч!'
    redirect_to root_path
  end

  private

  def sign_in(user)
    enter_session(user)
    remember(user) if params[:remember_me] == '1' # remember - метод который будет написанн в authenticate
    flash[:success] = "С возвращением, #{current_user.name_or_email}!"
    redirect_to root_path
  end
end
