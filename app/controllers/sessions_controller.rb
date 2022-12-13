# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create] # требуем что бы пользователь не был зарегистрирован
  before_action :require_authentication, only: :destroy
  before_action :set_user, only: :create
  def new; end

  def create
    if @user&.authenticate(params[:password]) # authenticate появился у нас благодаря has_secure_password (и он просто сверяет хеш введенных данных с хешем пароля в БД)
      # &. называется «Оператор безопасной навигации» он позволяет вам вызывать методы для объектов, не беспокоясь о том, что объект может быть nil(во избежание undefined method for nil:NilClassошибки)
      sign_in(@user)
      flash[:success] = t 'global.flash.user.comeback'
      redirect_to root_path
    else
      flash.now[:warning] = t 'global.flash.user.wrong_data' # flash.now рендерит сообщение на этом же запросе // flash на следующем запросе
      render :new
    end
  end

  def destroy
    exit_session
    flash[:success] = t 'global.flash.user.exit'
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find_by email: params[:email]
  end

  def sign_in(user)
    enter_session(user)
    remember(user) if params[:remember_me] == '1' # remember - метод который будет написанн в authenticate
  end
end
